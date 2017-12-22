//
//  RegisterVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 08/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI
import NVActivityIndicatorView

class RegisterVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTapped()
        dismissButton.layer.cornerRadius = 32
    }

    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if !termsSwitch.isOn {
            showAlert(title: "Terms of Use", message: "You need to accept the terms of use in order to register.")
            return
        }
        guard let first = firstName.text, let last = lastName.text, let mail = mail.text, let brand = IgniteAPI.brand, let password = password.text else { return }
        if [first, last, mail, brand, password].contains("") {
            showAlert(title: "Alert", message: "Please enter the required information first.")
            return
        } else {
            self.startAnimating(message: "Registering...", type: NVActivityIndicatorType.ballTrianglePath)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.stopAnimating()
            }
            IgniteAPI.createRestrictedUser(firstName: first, lastName: last, mail: mail, password: password) { (newUser, error) in
                self.stopAnimating()
                if let user = newUser {
                    IgniteAPI.currentUser = user
                    UserDefaults.standard.set(mail, forKey: "username")
                    UserDefaults.standard.set(password, forKey: "password")
                    self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
                } else {
                    if let error = error {
                        self.showAlert(title: "Registration Error", message: error)
                    } else {
                        self.showAlert(title: "Registration Error", message: UNKNOWN_ERROR)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "unwindToLogin":
            if let destVC = segue.destination as? LoginVC {
                destVC.viewDidLoad()
            }
        default:
            break
        }
    }
    
}
