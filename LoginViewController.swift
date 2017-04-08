//
//  LoginViewController.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-08.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
        Webservice.sharedInstance.login(withUsername: "Xgiovanneed@gmail.com", password: "teste123") { (loginResponse) in
            
            if loginResponse.success == true {
                
               print("Success")
                
            } else {
                
                print("Fail")

            }
        }
        
    }
}
