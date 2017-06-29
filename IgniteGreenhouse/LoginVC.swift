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
            IgniteAPI.login(username: username, password: password) { (response) in
                self.consoleText.text = IgniteAPI.currentUser?.accessToken
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
        }
    }

}
