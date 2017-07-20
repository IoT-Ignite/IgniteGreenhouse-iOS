//
//  MenuVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 03/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var userName: UILabel!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.sourceType = .savedPhotosAlbum
        } else {
            print("Photo album not available.")
        }; return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        profileName.delegate = self
        profileName.textColor = UIColor.white
        profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2
        IgniteAPI.getAuditor { (auditor) in
            Utilities.user = User(auditor: auditor)
            self.userName.text = Utilities.user?.email
            self.profileName.text = Utilities.user?.fullName
            guard let img = Utilities.user?.profileImg else { return }
            self.profileImg.image = img
        }
    }
    
    @IBAction func profileImgButtonPressed(sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Table View Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier: String!
        switch indexPath.row {
        case 0:
            identifier = "HomeMenu"
        case 1:
            identifier = "DevicesMenu"
        case 2:
            identifier = "NodesMenu"
        case 3:
            identifier = "SensorsMenu"
        case 4:
            identifier = "AddMenu"
        case 5:
            identifier = "LogoutMenu"
        default:
            identifier = "HomeMenu"
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MenuCell {
            return cell
        } else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var identifier: String!
        switch indexPath.row {
        case 0:
            identifier = "HomeVC"
        case 1:
            identifier = "DevicesVC"
        case 2:
            identifier = "NodesVC"
        case 3:
            identifier = "SensorsVC"
        case 4:
            identifier = "QRScannerVC"
        case 5:
            identifier = "Login"
        default:
            identifier = "HomeVC"
        }
        changeVC(withIdentifier: identifier)
    }
    
    // MARK: - Text Field Delegate Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Utilities.user?.fullName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Image Picker Delegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Utilities.user?.profileImg = img
            profileImg.image = img
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? QRScannerVC {
            IgniteAPI.login(username: MASTER_MAIL, password: MASTER_PASS) { (master, error) in
                Utilities.masterUser = master
                destVC.mode = .node
            }
        }
    }
    
}
