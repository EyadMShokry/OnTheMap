//
//  UserSession.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import Foundation

struct UserSession: Codable {
    let account: Account?
    let session: Session?
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

