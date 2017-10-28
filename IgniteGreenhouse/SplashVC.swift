//
//  SplashVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 28.10.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet weak var igniteGreenhouseAnimation: UIImageView!
    @IBOutlet weak var iotIgniteAnimation: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        igniteGreenhouseAnimation.animationImages = [UIImage]()
        for i in 0..<19 { igniteGreenhouseAnimation.animationImages!.append(UIImage(named: "animated_\(i)")!) }
        igniteGreenhouseAnimation.animationDuration = 3
        igniteGreenhouseAnimation.animationRepeatCount = 1
        igniteGreenhouseAnimation.startAnimating()
        iotIgniteAnimation.animationImages = [UIImage]()
        for i in 0..<4 { iotIgniteAnimation.animationImages!.append(UIImage(named: "iot_logo_\(i)")!) }
        iotIgniteAnimation.animationImages!.insert(UIImage(named: "iot_logo_0_1")!, at: 1)
        iotIgniteAnimation.animationImages!.insert(UIImage(named: "iot_logo_0_2")!, at: 2)
        iotIgniteAnimation.animationDuration = 1
        iotIgniteAnimation.animationRepeatCount = 1
        perform(#selector(self.startBrandAnimation), with: iotIgniteAnimation, afterDelay: 2)
        perform(#selector(self.dismissSplashScreen), with: igniteGreenhouseAnimation, afterDelay: 3)
    }
    
    @objc func dismissSplashScreen() {
        present(storyboard!.instantiateViewController(withIdentifier: "LoginVC"), animated: true, completion: nil)
    }
    
    @objc func startBrandAnimation() {
        iotIgniteAnimation.startAnimating()
    }

}
