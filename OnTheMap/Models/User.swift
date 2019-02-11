//
//  User.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    enum CodingKeys: String, CodingKey {
        case name = "nickname"
    }
}

