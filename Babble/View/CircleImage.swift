//
//  CircleImage.swift
//  Babble
//
//  Created by Pankaj on 30/11/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {


    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView()  {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
