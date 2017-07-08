//
//  RegisterVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 08/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var brand: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTapped()
    }

    @IBAction func registerPressed(_ sender: Any) {
        if let first = firstName.text, let last = lastName.text, let profile = profileName.text, let pass = password.text {
            IgniteAPI.register(firstName: first, lastName: last, password: pass, profileName: profile, completion: { (response) in
                print(response)
            })
        } else {
            showAlert(title: "Alert", message: "Please fill every field.")
        }
    }
    
}
