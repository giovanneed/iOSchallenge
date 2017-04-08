//
//  Webservice.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-08.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation
public class Webservice : NSObject, URLSessionDelegate {
    
    public static let sharedInstance = Webservice()
    
    let kClintID = "PAn11swGbMAVXVDbSCpnITx5Utsxz1co"
    let kConnection = "Username-Password-Authentication"
    let kScope = "openid"
    
    enum RouterMethod : String {
        
        case GET = "GET"
        case POST = "POST"
        case DELETE = "DELETE"
        case UPDATE = "UPDATE"
        
    }
    
    func createRequest(forURL url: String, method: RouterMethod, parameters: [String:String]?)->NSMutableURLRequest {
        
        
        let url = NSURL(string: "https://mimo-test.auth0.com/" + url)!
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        if let parameters = parameters {
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        
        return request
        
    }
}


extension NSMutableURLRequest {
    func execute(_ serverResult : @escaping (_ result: Result)-> Void){
        
        _ = URLSession.shared.dataTask(with: self as URLRequest) { (data, response, error) in

            var result = Result()
            
            guard let data = data else {
                serverResult(result)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                result.statusCode = httpResponse.statusCode
            }
            
            
            do {
                if let parsedJSON = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    result.data = parsedJSON
                    serverResult(result)
                    
                }
                

            } catch let error as NSError {
            
                //handle it
                print(error)
                
            }
        }.resume()
    }
}
