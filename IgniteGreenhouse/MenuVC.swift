//
//  MenuVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 03/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        profileName.delegate = self
        profileName.textColor = UIColor.white
//        userName.text = User.currentUser!.userName
//        profileName.text = User.currentUser!.displayName
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        if let url = User.currentUser?.photoURL {
//            profileImg.hnk_setImageFromURL(url)
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            identifier = "Login"
        default:
            identifier = "HomeVC"
        }
        changeVC(withIdentifier: identifier)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        User.currentUser?.displayName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
