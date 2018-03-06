//
//  Item.swift
//  GL-Test
//
//  Created by Marcelo Perretta on 06/03/2018.
//  Copyright © 2018 MAWAPE. All rights reserved.
//

import UIKit

import UIKit

let APIClientErrorDomain = "APIClientErrorDomain"
let APIClientErrorUnsuccessfulRequest   = 500
let APIClientErrorParseError            = 501

class APIClient: NSObject {
    static let baseURLPath = Bundle.main.object(forInfoDictionaryKey: "BaseURLKey") as? String
    
    enum HTTPMethod: String {
        case get    = "GET"
        case post   = "POST"
    }
    
    /// Singleton instance
    static let sharedInstance = APIClient()
    
    /// Sends a request to the server
    ///
    /// - parameter method:         The HTTP method. `GET` by default.
    /// - parameter baseURL:        API base URL.
    /// - parameter path:           The service path.
    /// - parameter queryString:    URL query portien. `nil` by default.
    /// - parameter parameters:     The body parameters. Empty dictionary by default.
    /// - parameter callback        Callback called once the server responds.
    func executeRequest(method:HTTPMethod = .get,
                        baseURL:String = baseURLPath!,
                        path:String,
                        queryString:String = "",
                        parameters: [String:Any] = [:],
                        headers: [String: String]?,
                        callback:@escaping(_ result: [[String: Any]]?,_ error: Error?) -> Void){
        
        var urlRequest = URLRequest(url: URL(string:baseURL + path + queryString)!)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        if let allHeaders = headers {
            for (key, value) in allHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            if let requestError = error {
                callback(nil, requestError)
            } else {
                
                let response = urlResponse as! HTTPURLResponse
                
                if response.statusCode == 200 {
                    if let jsonData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]]
                            callback(json, nil)
                        } catch {
                            do {
                                let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                                callback([json!], nil)
                            } catch {
                                callback(nil, error)
                            }
                        }
                    }
                } else {
                    
                    let error = NSError.error(domain: APIClientErrorDomain,
                                              code: APIClientErrorUnsuccessfulRequest,
                                              description: "Unsuccessful Request status code: \(response.statusCode)")
                    callback(nil, error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    /// Creates a query string from a dictionary
    ///
    /// - parameter fromParameters: The dictionary.
    static func queryString(fromParameters:[String:Any]) -> String {
        guard fromParameters.count > 0 else { return "" }
        
        var parameterString = ""
        for (key, value) in fromParameters {
            if parameterString.count > 0  {
                parameterString.append("&")
            }
            parameterString.append(key + "=" + (value is Int ? String(describing: value) : value as! String))
        }
        return "?" + parameterString
    }
}

// MARK: - Messages API extension

extension APIClient {
    
    /// Retrieves the top messages
    ///
    /// - parameter callback:     The service path.
    func getAllItems(callback: @escaping ([Item]?, Error?) -> Void){
        let queryString = APIClient.queryString(fromParameters: [:])
        let headersDic = [
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        APIClient.sharedInstance.executeRequest(path:"list",
                                                queryString: queryString, headers: headersDic) { (jsonResponse, error) in
                                                    if (error != nil){
                                                        callback(nil,error)
                                                    } else {
                                                        
                                                        let unableToParseError = NSError.error(domain: APIClientErrorDomain,
                                                                                               code: APIClientErrorParseError,
                                                                                               description: "Unable to parse messages.")
                                                        
                                                        if let json = jsonResponse {
                                                            guard let itemsJson = json as [[String:Any]]? else {
                                                                return callback(nil,unableToParseError)
                                                            }
                                                            
                                                            var items = [Item]()
                                                            for itemJson in itemsJson{
                                                                if let item = Item(json:itemJson){
                                                                    items.append(item)
                                                                }
                                                            }
                                                            
                                                            callback(items,nil)
                                                        } else {
                                                            callback(nil,unableToParseError)
                                                        }
                                                    }
        }
    }
}

