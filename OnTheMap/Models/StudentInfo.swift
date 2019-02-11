//
//  StudentInfo.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import Foundation

struct StudentInfo: Codable {
   // let user: User
    let id: String?
    let firstName: String?
    let lastName: String?
    let name: String?
    
    enum codingKeys: String, CodingKey {
        case id = "key"
        case lastName = "last_name"
        case firstName = "first_name"
        case name = "nickname"
    }
}

