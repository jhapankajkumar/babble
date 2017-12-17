//
//  ChatViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var navTitle: UILabel!
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataChanged(notification:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(notification:)), name: NOTIF_USER_CHANNEL_DID_SELECTED, object: nil)

        
        
        if AuthService.instance.isLoggedIn {
            print("Token: \(AuthService.instance.authToken)")
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
            
        }
        
        view.bindToKeyboard()
        
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(AddChannelViewController.closeTapped(_:)))
        self.view.addGestureRecognizer(closeTap)
        
        
        
    }
    @objc func closeTapped(_ notificaiton: NSNotification) {
        self.messageTextBox.resignFirstResponder()
    }
    
    @objc func userDataChanged(notification: NSNotification) {
        if AuthService.instance.isLoggedIn {
            getChannelAfterLogin()
        }
        else{
           self.navTitle.text = "Please Login"
        }
    }
    
    @objc func channelSelected(notification: Notification) {
        updateSelectedChannel()
    }
    
    func getChannelAfterLogin() {
        MessageService.instance.getChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateSelectedChannel()
                }
                else {
                    self.navTitle.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages()  {
        guard let channelId = MessageService.instance.selectedChannel._id else {
            return
        }
        MessageService.instance.getMessagesForChannel(channelId: channelId) { (success) in
            
        }
        
    }
    
    
    func updateSelectedChannel()  {
     let channelName = MessageService.instance.selectedChannel.name ?? ""
        navTitle.text = "#\(channelName)"
        getMessages()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel._id else {return}
            
            guard let message = messageTextBox.text else {return}
            
            SocketService.instance.sendMessage(messageBody: message, userId: UserDataService.instace.id, channelId: channelId, completion: {(success) in
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            })
            
        }
        
    }
    
}
