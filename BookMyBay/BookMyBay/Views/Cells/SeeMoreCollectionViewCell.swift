//
//  SeeMoreCollectionViewCell.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class SeeMoreCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpContentView()
    }
    
    func setUpContentView() {
        contentView.layer.borderColor = UIColor.systemTeal.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
