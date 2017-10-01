//
//  BorderButton.swift
//  Swoosh
//
//  Created by Pankaj on 26/09/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
  override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3.0
        
    }
}
