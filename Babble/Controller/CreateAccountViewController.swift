//
//  CreateAccountViewController.swift
//  Babble
//
//  Created by Pankaj on 06/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil
        )
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.text != "" else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            return
        }
        
        
        
        AuthService.instance.registerUser(with: email, password: password) { (success) in
            if(success) {
                print("user registered")
            }
            else {
                print("getError")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
}
