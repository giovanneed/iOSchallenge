//
//  Webservice+Authentication.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-08.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

public struct LoginResponse {
    
    var errorMessage : WebserviceError?
    var success : Bool = false
    var token : Token?
    
    init(){
        
    }
    
    
}

extension Webservice {
    
    func login(withUsername username:String, password:String, _ response : @escaping (_ response: LoginResponse)-> Void){
        
        
        let body = ["client_id" : kClintID,
                    "username" : username,
                    "password" : password,
                    "connection" : kConnection,
                    "scopr" : kScope]
        
        let request = createRequest(forURL: "oauth/ro", method: .POST, parameters: body)
        
        
        request.execute { (result) in
            
            var loginResponse = LoginResponse()
            
            
            if let statusCode = result.statusCode {
                
                switch statusCode {
               
                case 200:
                    loginResponse.success = true
                    loginResponse.token = Token.init(withModel: result.data)
                    self.loggedToken = loginResponse.token
                    response(loginResponse)
                    return
                    
                default:
                loginResponse.success = false
                loginResponse.errorMessage = WebserviceError.init(withModel: result.data)
                response(loginResponse)
                    return
                    
                }
            }
        }
        
        
    }
    
}
