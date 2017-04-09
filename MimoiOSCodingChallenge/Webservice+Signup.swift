//
//  Webservice+Signup.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-09.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//


/*
 
 curl --request POST \
 --url 'https://YOUR_AUTH0_DOMAIN/dbconnections/signup' \
 --header 'content-type: application/json' \
 --data '{"client_id":"YOUR_CLIENT_ID", "email":"EMAIL", "password":"PASSWORD", "connection":"CONNECTION"}'
 
 {"_id":"58e848c739c61c78fe17ae5b","email_verified":false,"email":"giovanneed@gmail.com"}


 */

import Foundation

public struct SignupResponse {
    
    var errorMessage : WebserviceError?
    var success : Bool = false
    var id : String?
    var email : String?
    var emailVerified : Bool = false
    
    init(){
        
    }
    
    init(withModel model:NSDictionary?) {
        
        guard let model = model else {
            return
        }
        
        if let modelID = model.value(forKeyPath: "_id") as? String {
            id = modelID
        }
        if let modelEmail = model.value(forKeyPath: "email") as? String {
            email = modelEmail
        }
        if let modelEmailVerified = model.value(forKeyPath: "email_verified") as? Int {
            emailVerified = modelEmailVerified == 1 ? true : false
        }

        
        
    }
    
    
}


extension Webservice {
    
    func signup(withEmail email:String, password:String, _ response : @escaping (_ response: SignupResponse)-> Void){
        
        
        let body = ["client_id" : kClintID,
                    "email" : email,
                    "password" : password,
                    "connection" : kConnection]
        
        let request = createRequest(forURL: "dbconnections/signup", method: .POST, parameters: body)
        
        
        request.execute { (result) in
            
            var signupResponse = SignupResponse()
            
            print(result.data)
            
            if let statusCode = result.statusCode {
                
                switch statusCode {
                    
                case 200:
                    signupResponse = SignupResponse.init(withModel: result.data)
                    signupResponse.success = true
                    response(signupResponse)
                    return
                    
                default:
                    signupResponse.success = false
                    signupResponse.errorMessage = WebserviceError.init(withModel: result.data)
                    response(signupResponse)
                    return
                    
                }
            }
        }
        
        
    }
    
}
