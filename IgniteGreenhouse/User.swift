//
//  User.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import IgniteAPI

class User {
    
    var igniteUser: IGUser!
    var email: String!
    var firstName: String!
    var lastName: String!
    var fullName: String!
    var profileImg: UIImage?
    
    init(auditor: IGAuditor) {
        guard let user = IgniteAPI.currentUser else { return }
        igniteUser = user
        email = auditor.mail
        firstName = auditor.firstName
        lastName = auditor.lastName
        fullName = auditor.firstName + " " + auditor.lastName
    }
    
}
