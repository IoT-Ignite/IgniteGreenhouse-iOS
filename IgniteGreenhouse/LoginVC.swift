//
//  LoginVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class LoginVC: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTapped()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        if username != "" && password != "" {
            IgniteAPI.login(username: username, password: password) { (user) in
                IgniteAPI.currentUser = user
                self.createMenu(withMainIdentifier: "HomeVC")
            }
        } else {
            showAlert(title: "Alert", message: "Please enter your credentials first.")
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        guard let mail = usernameField.text else { return }
        if mail != "" {
            IgniteAPI.forgotPassword(mail: mail) { (status) in
                if status.status == "OK" {
                    self.showAlert(title: "Forgot Password", message: "An e-mail is sent to you. Open the link to reset your password.")
                } else {
                    self.showAlert(title: "Forgot Password", message: UNKNOWN_ERROR)
                }
            }
        } else {
            showAlert(title: "Alert", message: "Please enter your e-mail first.")
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: nil)
    }

}
