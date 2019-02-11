//
//  Client.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/5/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

class Client: NSObject {
    var session = URLSession.shared
    var sessionID: String? = nil
    var userKey = ""
    var userName = ""
    
    override init() {
        super.init()
    }
    
    class func shared() -> Client {
        struct Singleton {
            static var shared = Client()
        }
        return Singleton.shared
    }
    
    enum APIType {
        case udacity
        case parse
    }
    
    private func buildURLFromParameters(_ parameters: [String: AnyObject], withPathExtension: String? = nil, apiType: APIType = .udacity) -> URL {
        var components = URLComponents()
        components.scheme = apiType == .udacity ? Constants.Udacity.apiScheme: Constants.Parse.apiScheme
        components.host = apiType == .udacity ? Constants.Udacity.apiHost: Constants.Parse.apiHost
        components.path = (apiType == .udacity ? Constants.Udacity.apiPath: Constants.Parse.apiPath) + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        for(key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        print(components.url!)
        return components.url!
    }
    
    func taskForGETMethod(_ method: String, parameters: [String: AnyObject], apiType: APIType = .udacity, completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: buildURLFromParameters(parameters, withPathExtension: method, apiType: apiType))
        
        if apiType == .parse {
            request.addValue(Constants.ParseParametersValues.APIKey, forHTTPHeaderField: Constants.ParseParameterKeys.apiKey)
            request.addValue(Constants.ParseParametersValues.applicationid, forHTTPHeaderField: Constants.ParseParameterKeys.applicationID)
        }
        
        let task = session.dataTask(with: request) {(data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError("An error happened with your request: \(error!.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned satus code other than 2XX!")
                return
            }
            
            guard let data = data else {
                sendError("No Data returned from your request")
                return
            }
            
            //Escaping the 5 securety charachters of Udacity
            var newData = data
            if apiType == .udacity {
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            completionHandlerForGET(newData, nil)
        }
        task.resume()
        return task
    }
    
    func taskForPOSTMethod(_ method: String, parameters: [String: AnyObject], requestHeaderParameters: [String: AnyObject]? = nil, jsonBody: String, apiType: APIType = .udacity, completionHandlerForPOST: @escaping(_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: buildURLFromParameters(parameters, withPathExtension: method, apiType: apiType))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: .utf8)
        
        if let headersParam = requestHeaderParameters {
            for (key, value) in headersParam {
                request.addValue("\(value)", forHTTPHeaderField: key)
            }
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your credentials and try again.")
            case 200 ..< 299:
                break
            default:
                sendError("Your request returned a status code other than 2xx!")
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            var newData = data
            if apiType == .udacity {
                print(data.count)
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            
            completionHandlerForPOST(newData, nil)
            
        }
        task.resume()
        
        return task
    }
    
    func taskForPUTMethod(_ method: String,parameters: [String:AnyObject], requestHeaderParameters: [String:AnyObject]? = nil, jsonBody: String, apiType: APIType = .udacity, completionHandlerForPUT: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: buildURLFromParameters(parameters, withPathExtension: method, apiType: apiType))
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        
        if let headersParam = requestHeaderParameters {
            for (key, value) in headersParam {
                request.addValue("\(value)", forHTTPHeaderField: key)
            }
        }
        
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPUT(nil, NSError(domain: "taskForPUTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your credentials and try again.")
            case 200 ..< 299:
                break
            default:
                sendError("Your request returned a status code other than 2xx!")
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            // skipping the first 5 characters for Udacity API calls
            var newData = data
            if apiType == .udacity {
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
                        
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            completionHandlerForPUT(newData, nil)
            
        }
        task.resume()
        return task
    }

    
    func taskforDELETEMethod(_ method: String, parameters: [String: AnyObject], apiType: APIType = .udacity, completionHandlerForDELETE: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: buildURLFromParameters(parameters, withPathExtension: method, apiType: apiType))
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = session.dataTask(with: request) {(data, response, error) in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForDELETE(nil, NSError(domain: "taskForDeleteMethod", code: 1, userInfo: userInfo))
            }
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your credentials and try again.")
            case 200 ..< 299:
                break
            default:
                sendError("Your request returned a status code other than 2xx!")
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            var newData = data
            if apiType == .udacity {
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            
            completionHandlerForDELETE(newData, nil)
        }
        task.resume()
        return task
    }
    
    
    
    
    
    
}




