//
//  Constants.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import Foundation

struct Constants {
    
    struct HTTPHeaderField {
        static let accept = "Accept"
        static let contentType = "Content-Type"
    }
    
    struct HTTPHeaderFieldValue {
        static let json = "application/json"
    }
    
    struct Udacity {
        static let apiScheme = "https"
        static let apiHost = "onthemap-api.udacity.com"
        static let apiPath = "/v1/"
    }
    
    struct UdacityMethods {
        static let authantication = "session"
        static let users = "users"
    }
    
    struct UdacityJSONResponseKeys {
        static let account = "account"
        static let registered = "registered"
        static let userKey = "key"
        static let session = "session"
        static let sessionId = "id"
    }
    
    struct Parse {
        static let apiScheme = "https"
        static let apiHost = "parse.udacity.com"
        static let apiPath = "/parse"
    }
    
    struct ParseMethods {
        static let studentLocation = "/classes/StudentLocation"
    }
    
    struct ParseJSONResponseKeys {
        static let results = "results"
    }
    
    struct ParseParameterKeys {
        static let apiKey = "X-Parse-REST-API-Key"
        static let applicationID = "X-Parse-Application-Id"
        static let Where = "where"
        static let order = "order"
    }
    
    struct ParseParametersValues {
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let applicationid = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    
    
}
