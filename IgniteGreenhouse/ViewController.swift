//
//  ViewController.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

// curl -X POST -d 'grant_type=password&amp;username=USERNAME&amp;password=PASSWORD' --user ':' https://api.ardich.com/api/v3/login/oauth

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var consoleText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginPressed(_ sender: Any) {
        print(Alamofire.request("https://httpbin.org/get"))
    }

}

