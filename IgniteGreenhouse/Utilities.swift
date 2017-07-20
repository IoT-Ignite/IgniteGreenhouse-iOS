//
//  Utilities.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import IgniteAPI

class Utilities {
    
    static var user: User?
    static var masterUser: IGUser?
    
    static func createActivityIndicator(view: UIView) -> UIActivityIndicatorView {
        
        let container: UIView = UIView()
        container.frame = view.frame
        container.center = view.center
        
        container.backgroundColor = UIColor(hexString: "0xffffff")
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(hexString: "0x444444") // a 0.7
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        view.addSubview(container)
        
        return actInd
        
    }
    
}
