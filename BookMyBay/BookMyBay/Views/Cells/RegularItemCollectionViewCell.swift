//
//  RegularItemCollectionViewCell.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class RegularItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpContentView()
    }
    
    func setUpContentView() {
        contentView.layer.borderColor = UIColor.systemTeal.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowColor = UIColor.systemTeal.cgColor
        contentView.layer.shadowOpacity = 0.2
    }
    
    @IBAction func didTapAddToFavoritesButton(_ sender: UIButton) {
    }
}
