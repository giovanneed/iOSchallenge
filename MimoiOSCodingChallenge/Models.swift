//
//  Models.swift
//  
//
//  Created by Giovanne Dias on 2017-04-08.
//
//

import Foundation


public struct Token {
    
    var accessToken : String?
    var tokenType : String?
    
    init(withModel model:NSDictionary?){
        
        guard let model = model else {
            return
        }
        
        if let modelAccessToken = model.value(forKeyPath: "access_token") as? String {
            accessToken = modelAccessToken
        }
        if let modelTokenType = model.value(forKeyPath: "token_type") as? String {
            tokenType = modelTokenType
        }
    }
    
    var parsed : String {
        
        if let unwrappedTokenType = tokenType , let unwrappedAccessToken = accessToken {
            return unwrappedTokenType + " " + unwrappedAccessToken
        }
        
        return ""
    }
}

public struct WebserviceError {
    
    var error : String?
    var errorDescription = ""
    
    init(withModel model:NSDictionary?) {
        
        guard let model = model else {
            return
        }
        
        if let modelError = model.value(forKeyPath: "error") as? String {
            error = modelError
        }
        if let modelErrorDescription = model.value(forKeyPath: "error_description") as? String {
            errorDescription = modelErrorDescription
        }
        
    }
}

public struct Result {
    
    var error : Error?
    var data : NSDictionary?
    var statusCode : Int?
    
    init(withError error: Error){
        self.error = error
    }
    
    init(withParsedData data: NSDictionary){
        self.data = data
    }
    
    init(){
        
    }
}
