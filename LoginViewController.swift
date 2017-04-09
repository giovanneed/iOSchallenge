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
        
       /* Webservice.sharedInstance.signup(withEmail: "teste125@gmail.com", password: "teste123") { (response) in
            
            if response.success == true {
                
                print(response.id)
                
                self.showSimpleAlertWithMessage(message: "New User Successfully Registered!", title: "Success")
                
            } else {
                if let error =  response.errorMessage {
                    self.showErrorAlert(withWebserviceError: error)
                }
            }
            
        }*/
        
        
        Webservice.sharedInstance.login(withUsername: "giovanneed@gmail.com", password: "teste123") { (loginResponse) in
            
            if loginResponse.success == true {
                                
                let vc = SettingsViewController()
                vc.email = "giovanneed@gmail.com"
                
                self.present(vc, animated: true) {
                    
                }
                
            } else {
                if let error =  loginResponse.errorMessage {
                    self.showErrorAlert(withWebserviceError: error)
                }
            }
        }
        
    }
}
