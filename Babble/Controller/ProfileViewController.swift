//
//  ProfileViewController.swift
//  Babble
//
//  Created by Pankaj on 14/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileData()
    }

    func setProfileData()  {
        self.profileImage.image = UIImage(named: UserDataService.instace.avatarName)
        self.profileImage.backgroundColor = UserDataService.instace.getColor(colors: UserDataService.instace.avatarColor)
        self.userEmail.text = UserDataService.instace.email
        self.userName.text = UserDataService.instace.name
        self.containerView.layer.cornerRadius = 6.0
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(ProfileViewController.closeTapped(_:)))
        backGroundView.addGestureRecognizer(closeTap)
    }
    
    

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil
        )
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        UserDataService.instace.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
  @objc func closeTapped(_ notificaiton: NSNotification) {
        dismiss(animated: true, completion: nil)
    }
    


}
