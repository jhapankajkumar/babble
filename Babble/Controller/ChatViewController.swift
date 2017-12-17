//
//  ChatViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var messageListTableView: UITableView!
    
    var isTyping = false
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.isHidden = true
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataChanged(notification:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(notification:)), name: NOTIF_USER_CHANNEL_DID_SELECTED, object: nil)
        
        messageListTableView.rowHeight = UITableViewAutomaticDimension
        messageListTableView.estimatedRowHeight = 80
        
        if AuthService.instance.isLoggedIn {
            print("Token: \(AuthService.instance.authToken)")
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
            
        }
        
        SocketService.instance.getMessage { (success) in
            if success {
                self.messageListTableView.reloadData()
                self.showLastRow()
            }
        }
        
        view.bindToKeyboard()
        showLastRow()
        
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(AddChannelViewController.closeTapped(_:)))
        self.view.addGestureRecognizer(closeTap)
        
    }
    
    func showLastRow() {
        if AuthService.instance.isLoggedIn {
            if MessageService.instance.messages.count > 0 {
                let indexPath = NSIndexPath(row: MessageService.instance.messages.count-1, section: 0)
                self.messageListTableView?.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: false)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLastRow()
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
            messageListTableView.reloadData()
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
            if success {
                self.messageListTableView.reloadData()
                self.showLastRow()
            }
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
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
        }
        else {
            if isTyping == false {
                sendButton.isHidden = false
            }
            isTyping = true
        }

    }
}

extension ChatViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configuareCell(message: message)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}











