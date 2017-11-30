//
//  AvatarCell.swift
//  Babble
//
//  Created by Pankaj on 30/11/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupView()  {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius =  10.0
        self.clipsToBounds = true
    }
}
