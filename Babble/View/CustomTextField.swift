//
//  CurrencyTextField.swift
//  window-shopper
//
//  Created by Pankaj on 28/09/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit
@IBDesignable
class CustomTextField: UITextField {
    
    
   /* override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        let currencyLabel = UILabel(frame: CGRect(x: 5, y: frame.size.height/2 - size/2, width: size, height: size))
        currencyLabel.backgroundColor = #colorLiteral(red: 0.8374213576, green: 0.8374213576, blue: 0.8374213576, alpha: 1)
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        currencyLabel.layer.cornerRadius = 5.0
        currencyLabel.clipsToBounds = true
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.locale = .current
        currencyLabel.text = formater.currencySymbol
        //addSubview(currencyLabel)
    }
 */
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView()  {
        //backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.24609375)
        layer.cornerRadius = 5.0
        textAlignment = .left
        clipsToBounds = true
        textColor = UIColor.black
        /*if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor  : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
 */
    }
}
