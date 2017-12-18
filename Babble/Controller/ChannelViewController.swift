//
//  ChannelViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,AddChannelVCDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButton: UIButton!
    
    var channels = [Channel]()
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width  - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.channelLoaded(notification:)), name: NOTIF_USER_CHANNEL_DID_LOADED, object: nil)
        
        SocketService.instance.getChannel(completion: { (success) in
            self.tableView .reloadData()
        })
        
        SocketService.instance.getMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel._id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannelids.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @objc func userDataDidChange(_ notification: NSNotification) {
        setupUserInfo()
    }
    @objc func channelLoaded(notification: Notification){
        tableView.reloadData()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profileView = ProfileViewController()
            profileView.modalPresentationStyle = .custom
            present(profileView, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    func setupUserInfo()  {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instace.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instace.avatarName)
            userImage.backgroundColor = UserDataService.instace.getColor(colors: UserDataService.instace.avatarColor)
            
        }
        else {
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profileView = AddChannelViewController()
            profileView.delegate = self
            profileView.modalPresentationStyle = .custom
            present(profileView, animated: true, completion: nil)
            
        }
    }
    
    
    func channelAdded() {
    }
}

extension ChannelViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell else {
            return UITableViewCell()
        }
        cell.configureCell(channel: MessageService.instance.channels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannelids.count > 0{
            MessageService.instance.unreadChannelids = MessageService.instance.unreadChannelids.filter({$0 != channel._id})
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        
        NotificationCenter.default.post(name: NOTIF_USER_CHANNEL_DID_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
    }
    
}

