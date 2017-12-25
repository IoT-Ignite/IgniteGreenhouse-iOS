
//
//  QRScannerVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 10/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import AVFoundation
import IgniteAPI
import NVActivityIndicatorView

class QRScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate, NVActivityIndicatorViewable {
    
    enum Mode {
        case device
        case sensor
    }
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var mode = Mode.sensor
    var thingCode: String?
    var deviceCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            guard let captureDevice = captureDevice else { return }
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        } else {
            self.startAnimating()
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                self.stopAnimating()
                let str = metadataObj.stringValue
                connection.isEnabled = false
                switch mode {
                case .device:
                    deviceCode = str
                    guard let enduser = IgniteAPI.currentEnduser else { return }
                    let config = IGDROMConfiguration(appKey: APP_KEY, enduser: enduser)
                    IgniteAPI.addDROMConfiguration(configuration: config, configurationName: enduser.mail, tenantDomain: TENANT_DOMAIN, completion: { (configurationId, error) in
                        if let id = configurationId {
                            IgniteAPI.addDROMDeviceConfiguration(configurationId: id, deviceId: self.deviceCode!, tenantDomain: TENANT_DOMAIN, completion: { (response) in
                                print(response)
                                IgniteAPI.pushDROMDeviceConfiguration(deviceId: self.deviceCode!, completion: { (response) in
                                    let alert = UIAlertController(title: "Device: \(self.deviceCode!)", message: response.description, preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                        self.changeVC(withIdentifier: "DevicesVC")
                                    })
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                })
                            })
                        } else {
                            guard let error = error else { return }
                            print(error)
                            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                self.viewDidLoad()
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true)
                        }
                    })
                case .sensor:
                    thingCode = str
                    let alert = UIAlertController(title: "Sensor Found!", message: "ID: \(thingCode!)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "toAdd", sender: nil)
                    })
                    alert.addAction(action)
                    present(alert, animated: true)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? AddVC {
            guard let code = thingCode else { print("Code not picked."); return }
            destVC.thingCode = code
        }
    }

}
