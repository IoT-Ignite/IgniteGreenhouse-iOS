//
//  AboutVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 25.12.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func websiteButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://www.iot-ignite.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
