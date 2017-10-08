
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

class QRScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    enum Mode {
        case device
        case node
    }
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var mode = Mode.node
    var thingCode: String?
    var deviceCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
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
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                let str = metadataObj.stringValue
                connection.isEnabled = false
                switch mode {
                case .device:
                    deviceCode = str
                    guard let enduser = IgniteAPI.currentEnduser else { return }
                    let config = IGDROMConfiguration(appKey: APP_KEY, enduser: enduser)
                    IgniteAPI.addDROMConfiguration(configuration: config, configurationName: enduser.mail, tenantDomain: TENANT_DOMAIN, completion: { (configurationId, error) in
                        print(configurationId ?? "Hata var", error ?? "Hata yok")
                        if let id = configurationId {
                            IgniteAPI.addDROMDeviceConfiguration(configurationId: id, deviceId: self.deviceCode!, tenantDomain: TENANT_DOMAIN, completion: { (response) in
                                IgniteAPI.pushDROMDeviceConfiguration(deviceId: self.deviceCode!, completion: { (response) in
                                    let alert = UIAlertController(title: "DROM", message: response.description, preferredStyle: .actionSheet)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                        self.navigationController?.popToRootViewController(animated: true)
                                    })
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                })
                            })
                        } else {
                            print(error!)
                        }
                    })
                case .node:
                    thingCode = str
                    let alert = UIAlertController(title: "Found", message: str, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "toAdd", sender: nil)
                    })
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
                }
                //messageLabel.text = metadataObj.stringValue
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
