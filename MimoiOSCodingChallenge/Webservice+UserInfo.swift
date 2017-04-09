//
//  Webservice+UserInfo.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-09.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//


/*
 
 curl --request GET \
 --url 'https://mimo-test.auth0.com/userinfo' \
 --header 'authorization: Bearer CpNRLWAqYomTm2aJ' \
 --header 'content-type: application/json'
 
 {
 "email_verified": false,
 "email": "test.account@userinfo.com",
 "clientID": "q2hnj2iu...",
 "updated_at": "2016-12-05T15:15:40.545Z",
 "name": "test.account@userinfo.com",
 "picture": "https://s.gravatar.com/avatar/dummy.png",
 "user_id": "auth0|58454...",
 "nickname": "test.account",
 "identities": [
 {
 "user_id": "58454...",
 "provider": "auth0",
 "connection": "Username-Password-Authentication",
 "isSocial": false
 }
 ],
 "created_at": "2016-12-05T11:16:59.640Z",
 "sub": "auth0|58454..."
 }
 
 */


import Foundation

public struct UserInfoResponse {
    
    var errorMessage : WebserviceError?
    var success : Bool = false
    var email : String?
    var name : String?
    var picture : String?
    
    init(){
        
    }
    
    init(withModel model:NSDictionary?) {
        
        guard let model = model else {
            return
        }
        
        if let modelName = model.value(forKeyPath: "name") as? String {
            name = modelName
        }
        if let modelEmail = model.value(forKeyPath: "email") as? String {
            email = modelEmail
        }
        if let modelPicture = model.value(forKeyPath: "picture") as? String {
            picture = modelPicture
        }
        
        
        
    }
    
    
}

extension Webservice {
    
    
    
    func getUserInfo(_ response : @escaping (_ response: UserInfoResponse)-> Void){
        
        let request = createRequest(forURL: "userinfo", method: .GET, parameters: nil)

        request.execute { (result) in

            var userInfoResponse = UserInfoResponse()

            
            if let statusCode = result.statusCode {
                
                switch statusCode {
                    
                case 200:
                    userInfoResponse = UserInfoResponse.init(withModel: result.data)
                    userInfoResponse.success = true
                    response(userInfoResponse)
                    return
                    
                default:
                    userInfoResponse.success = false
                    userInfoResponse.errorMessage = WebserviceError.init(withModel: result.data)
                    response(userInfoResponse)
                    return
                    
                }
            }

        }
    }


}


