//
//  AddChannelViewController.swift
//  Babble
//
//  Created by Pankaj on 16/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    @IBOutlet weak var channelDescription: CustomTextField!
    @IBOutlet weak var channelName: CustomTextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    weak var delegate : AddChannelVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.layer.cornerRadius = 6.0
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(AddChannelViewController.closeTapped(_:)))
        backgroundView.addGestureRecognizer(closeTap)
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelBtnPressed(_ sender: Any) {
        if let channelName = self.channelName.text, self.channelName.text != nil, let description = self.channelDescription.text , self.channelDescription.text != nil {
            SocketService.instance.addChannel(channelName: channelName, channelDesc: description, completion: { (success) in
                if success {
                    self.delegate?.channelAdded()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @objc func closeTapped(_ notificaiton: NSNotification) {
        dismiss(animated: true, completion: nil)
    }
}

protocol AddChannelVCDelegate: class {
    func channelAdded()
}


