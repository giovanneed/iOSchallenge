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

    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var registerPassword: UITextField!
    @IBOutlet var confirmRegisterPassword: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
  
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let txtLogin = login.text , let txtPassword = password.text else {
            self.showSimpleAlertWithMessage(message: "Email and password needed!", title: "Error")
            return
        }
        
        self.showLoading()
        Webservice.sharedInstance.login(withUsername: txtLogin, password: txtPassword) { (loginResponse) in
            
            if loginResponse.success == true {
                
                Webservice.sharedInstance.getUserInfo({ (response) in
                    
                    let vc = SettingsViewController()
                    
                    if let email = response.email {
                        vc.email = email
                    }
                    if let pic = response.picture {
                        vc.pictureURL = pic
                    }
                    self.checkIfIsNewUser(byLogin: vc.email)
                    DispatchQueue.main.async {
                        self.present(vc, animated: true) {}
                    }
                   
                })
                                
                
            } else {
                if let error =  loginResponse.errorMessage {
                    self.showErrorAlert(withWebserviceError: error)
                }
            }
            self.unshowLoading()
        }
        
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        
        guard let txtEmail = email.text , let txtRegisterPassword = registerPassword.text, let txtConfirmRegisterPassword = confirmRegisterPassword.text else {
            self.showSimpleAlertWithMessage(message: "Email and password needed!", title: "Error")
            return
        }
        
        if txtRegisterPassword != txtConfirmRegisterPassword {
             self.showSimpleAlertWithMessage(message: "Passwords doesn't mach!", title: "Error")
            return
        }
        
        self.showLoading()

        Webservice.sharedInstance.signup(withEmail: txtEmail, password: txtRegisterPassword) { (response) in
            
            if response.success == true {
                                
                self.showSimpleAlertWithMessage(message: "New User Successfully Registered!", title: "Success")
                DispatchQueue.main.async {

                    self.login.text = self.email.text
                    self.password.text = self.registerPassword.text
                    self.email.text = ""
                    self.registerPassword.text = ""
                    self.confirmRegisterPassword.text = ""
                }
                
                
                
            } else {
                if let error =  response.errorMessage {
                    self.showErrorAlert(withWebserviceError: error)
                }
            }
            self.unshowLoading()

        }
    }
    
    func checkIfIsNewUser(byLogin login:String){
        
        let lastUser = UserDefaults.standard.string(forKey: "LastUser")
        
        if login != lastUser {
            UserDefaults.standard.set(login, forKey: "LastUser")
            UserDefaults.standard.set(false, forKey: "DarkMode")

        }

    }
}
