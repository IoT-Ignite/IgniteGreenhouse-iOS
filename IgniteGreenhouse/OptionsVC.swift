//
//  OptionsVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 10/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class OptionsVC: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? HomeVC {
            destVC.startDate = startDatePicker.date.timeIntervalSince1970
            destVC.endDate = endDatePicker.date.timeIntervalSince1970
            destVC.refreshData(destVC.refreshControl)
        }
    }
    
}
