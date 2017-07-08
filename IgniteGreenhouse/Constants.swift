//
//  Constants.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import ViewDeck

// curl -X POST -d 'grant_type=password&amp;username=USERNAME&amp;password=PASSWORD' --user ':' https://api.ardich.com/api/v3/login/oauth

let API_URL = "https://api.ardich.com/api/v3"
let TENANT_MAIL = "greenhouse@iot-ignite.com"
let APP_KEY = "2bb69ddce24f4021a1c6b77f1ab9302c"

extension UIViewController {
    
    func changeVC(identifier: String) {
        let vc = storyboard!.instantiateViewController(withIdentifier: identifier)
        let button = UIBarButtonItem(image: UIImage(named: "menubutton"), style: .plain, target: nil, action: #selector(UIViewController.showMenu))
        vc.navigationItem.setLeftBarButton(button, animated: false)
        let nc = UINavigationController(rootViewController: vc)
        viewDeckController?.centerViewController = nc
        viewDeckController?.closeSide(true)
    }
    
    func showMenu() {
        viewDeckController?.open(.left, animated: true)
    }
    
    func dismissKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
