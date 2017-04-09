//
//  Extensions.swift
//  MimoiOSCodingChallenge
//
//  Created by Giovanne Dias on 2017-04-08.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation



extension UIViewController {
    
    func showErrorAlert(withWebserviceError error: WebserviceError){
        
        let alert = UIAlertController(title: "Error", message:error.errorDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSimpleAlertWithMessage(message: String, title: String) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showLoading() {
        
        let viewLoading : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height))
        viewLoading.tag = 182
        viewLoading.backgroundColor = UIColor.black
        viewLoading.alpha = 0.5
        
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        
        
        let activityIndicate : UIActivityIndicatorView = UIActivityIndicatorView.init(frame: CGRect(x: view.frame.size.width/2 - 10, y: view.frame.size.height/2 - 10, width: 20, height: 20))
        activityIndicate.startAnimating()
        
        viewLoading.addSubview(activityIndicate)
        view.addSubview(viewLoading)
    }
    
    func unshowLoading() {
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        removeSubviewByTag(tag:182)
    }
    
    func removeSubviewByTag(tag : Int){
        for viewSearched in view.subviews {
            if viewSearched.tag == tag {
                DispatchQueue.main.async {
                    viewSearched.removeFromSuperview()
                }
                break
            }
        }
    }

}
