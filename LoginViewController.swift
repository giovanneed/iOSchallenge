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
        
        Webservice.sharedInstance.login(withUsername: "giovanneed@gmail.com", password: "teste123") { (loginResponse) in
            
            if loginResponse.success == true {
                                
                let vc = SettingsViewController()
                
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
