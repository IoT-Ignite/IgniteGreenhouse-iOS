//
//  Constants.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

// curl -X POST -d 'grant_type=password&amp;username=USERNAME&amp;password=PASSWORD' --user ':' https://api.ardich.com/api/v3/login/oauth

let API_URL = "https://api.ardich.com/api/v3"

extension UIViewController {
    
    func dismissKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
