//
//  StudentsLocation.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import Foundation

struct StudentsLocation {
    static var shared = StudentsLocation()
    private init() {}
    var studentsInformation = [StudentInformation]()
}

