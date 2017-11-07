//
//  AutoInsettingUICollectionViewController.swift
//  Tabman-UITests
//
//  Created by Merrick Sapsford on 26/10/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

class AutoInsettingUICollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutoInsettingCollectionViewCell.reuseIdentifier, for: indexPath) as! AutoInsettingCollectionViewCell
        
        cell.titleLabel.text = "Row \(indexPath.row)"
        
        cell.backgroundColor = .lightGray
        
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let sectionInset = flowLayout.sectionInset
        let bounds = collectionView.bounds
        return CGSize(width: bounds.size.width - (sectionInset.left + sectionInset.right), height: 300)
    }
}

class AutoInsettingCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AutoInsettingCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12.0
    }
}
