//
//  CurrencyTextField.swift
//  window-shopper
//
//  Created by Pankaj on 28/09/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit
class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView()  {
        //backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.24609375)
        layer.cornerRadius = 5.0
        textAlignment = .left
        clipsToBounds = true
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor  : #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 1)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 1)
        }

    }
}
