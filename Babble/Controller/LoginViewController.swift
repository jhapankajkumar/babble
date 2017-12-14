//
//  LoginViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.isHidden = true
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func logginButtonPressed(_ sender: Any) {
        view.endEditing(true)
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        guard let email = userNameTextField.text, userNameTextField.text != "" else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            return
        }
        AuthService.instance.loginUser(withUserName: email, andPassword: password) { (success) in
            
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            if(success) {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            else {
                print("failure")
            }
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
}
