//
//  ChannelViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width  - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func userDataDidChange(_ notification: NSNotification) {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instace.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instace.avatarName)
            userImage.backgroundColor = UserDataService.instace.getColor(colors: UserDataService.instace.avatarColor)
            
        }
        else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            performSegue(withIdentifier: TO_PROFILE_VIEW, sender: nil)
        }
        else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }

}
