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
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 5.0
        
    }
}
