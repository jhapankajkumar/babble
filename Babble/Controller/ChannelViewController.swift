//
//  ChannelViewController.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width  - 60
        // Do any additional setup after loading the view.
    }



}
