//
//  CreateAccountViewController.swift
//  Babble
//
//  Created by Pankaj on 06/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    //outlets
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var userImage: UIImageView!
    var bgColor : UIColor?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instace.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instace.avatarName)
            avatarName = UserDataService.instace.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil
        )
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.text != "" else {return}
        guard let password = passwordTextField.text, passwordTextField.text != "" else {return}
        guard let name  = userNameTextField.text, userNameTextField.text != "" else {return}
//        guard let avatar
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success) in
            if(success) {
                AuthService.instance.loginUser(withUserName: email, andPassword: password, completion: { (success) in
                    if(success){
                        print(AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instace.name,UserDataService.instace.avatarName);
                                self.loadingIndicator.stopAnimating()
                                self.loadingIndicator.isHidden = true
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
            else {
                print("getError")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil);
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        avatarColor = "[\(red),\(green), \(blue), 1]"
        UIView.animate(withDuration: 0.2) {
          self.userImage.backgroundColor = self.bgColor
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
