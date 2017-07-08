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
let TENANT_MAIL = "dorukgezici@gmail.com"//"greenhouse@iot-ignite.com"
let APP_KEY = "a75358a5494549f78a2e8cf12d69aaac"//"2bb69ddce24f4021a1c6b77f1ab9302c"

extension UIViewController {
    
    func changeVC(withIdentifier: String) {
        if withIdentifier == "Login" {
            IgniteAPI.logout()
            let nc = storyboard!.instantiateViewController(withIdentifier: withIdentifier)
            UIApplication.shared.keyWindow?.rootViewController = nc
        } else {
            let vc = storyboard!.instantiateViewController(withIdentifier: withIdentifier)
            let button = UIBarButtonItem(image: UIImage(named: "menubutton"), style: .plain, target: nil, action: #selector(UIViewController.showMenu))
            vc.navigationItem.setLeftBarButton(button, animated: false)
            let nc = UINavigationController(rootViewController: vc)
            viewDeckController?.centerViewController = nc
            viewDeckController?.closeSide(true)
        }
    }
    
    func createMenu(withMainIdentifier: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = sb.instantiateViewController(withIdentifier: withMainIdentifier)
        let center = UINavigationController(rootViewController: mainVC)
        let menuVC = sb.instantiateViewController(withIdentifier: "MenuVC")
        let left = UINavigationController(rootViewController: menuVC)
        left.preferredContentSize = CGSize(width: window.bounds.width * 0.75, height: window.bounds.height)
        let viewDeckController = IIViewDeckController(center: center, leftViewController: left)
        window.rootViewController = viewDeckController
        window.makeKeyAndVisible()
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

extension NSCoder {
    func decodeString(forKey key: String) -> String {
        return decodeObject(forKey: key) as? String ?? ""
    }
    func decodeData(forKey key: String) -> Data {
        return decodeObject(forKey: key) as? Data ?? Data()
    }
}
