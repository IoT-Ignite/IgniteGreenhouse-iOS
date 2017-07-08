//
//  LoginVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        if let username = usernameField.text, let password = passwordField.text {
            IgniteAPI.login(username: username, password: password) { (user) in
                IgniteAPI.currentUser = user
                self.createMenu(withMainIdentifier: "HomeVC")
            }
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        showAlert(title: "Forgot your password?", message: "We sent you a new password, check your e-mail!")
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: nil)
    }

}
