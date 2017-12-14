//
//  AvatarPickerViewController.swift
//  Babble
//
//  Created by Pankaj on 30/11/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit


class AvatarPickerViewController: UIViewController {

    @IBOutlet weak var avatarCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //variable
    var avatarType = AvatarType.dark
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentControlChanged(_ sender: Any) {
        if self.segmentControl.selectedSegmentIndex == 0 {
            avatarType = AvatarType.dark
        }
        else{
            avatarType = AvatarType.light;
        }
        avatarCollectionView.reloadData()
    }
    
    
}


extension AvatarPickerViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configure(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
}

extension AvatarPickerViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instace.setAvatarName(avatarName: "dark\(indexPath.item)")
        }
        else {
            UserDataService.instace.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColums : CGFloat =  3
        if UIScreen.main.bounds.width > 320 {
            numberOfColums = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColums - 1) * spaceBetweenCells)/numberOfColums
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
}

//protocol AvatarPickerViewControllerDelegate {
//
//}




