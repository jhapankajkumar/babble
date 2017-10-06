//
//  CreateAccountViewController.swift
//  Babble
//
//  Created by Pankaj on 06/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil
        )
        
    }
    
    

}
