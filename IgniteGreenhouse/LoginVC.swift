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

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var consoleText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTapped()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        if username == "" || password == "" { return }
        IgniteAPI.login(username: username, password: password) { (user) in
            IgniteAPI.currentUser = user
            self.createMenu(withMainIdentifier: "HomeVC")
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        guard let mail = usernameField.text else { return }
        if mail == "" {
            showAlert(title: "Alert", message: "Please enter your e-mail first.")
            return
        }
        IgniteAPI.forgotPassword(mail: mail) { (response) in
            self.showAlert(title: "Forgot Password", message: "\(response)")
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: nil)
    }

}
