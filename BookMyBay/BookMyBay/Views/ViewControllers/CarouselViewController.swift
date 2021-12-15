//
//  CarouselViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 14/12/21.
//

import UIKit

class CarouselViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CarouselDelegate?
    var booksData: [BookModel]?
    var type: CarouselType? {
        didSet {
            guard let type = type else {
                return
            }
            titleLabelText = type.title
            shoulShowSeeMoreCell = type.shouldShowSeeMoreCell
            seeMoreCellTitle = type.seeMoreCellTitle ?? "See\nmore"
        }
    }
    
    private var titleLabelText: String = "Carousel of books" {
        didSet {
            guard view != nil else { return }
            titleLabel.text = titleLabelText
        }
    }
    
    private var shoulShowSeeMoreCell: Bool = false
    private var seeMoreCellTitle: String = "See\nmore"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        registerCells()
        titleLabel.text = titleLabelText
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: Constants.Identifier.regularItemCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Identifier.regularItemCollectionViewCell)
        collectionView.register(UINib(nibName: Constants.Identifier.seeMoreCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Identifier.seeMoreCollectionViewCell)
    }
    
    func setTitle(_ text: String) {
        titleLabelText = text
    }
    
    func shouldShowSeeMoreCell(_ shouldShow: Bool) {
        shoulShowSeeMoreCell = shouldShow
    }
    
    func shouldShowSeeMoreCell(withTitle title: String) {
        seeMoreCellTitle = title
        shoulShowSeeMoreCell = true
    }
}

extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let booksData = booksData else { return 0 }
        let numberOfItemsInSection = shoulShowSeeMoreCell ? booksData.count + 1 : booksData.count
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let booksData = booksData, indexPath.row < booksData.count else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.seeMoreCollectionViewCell, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.regularItemCollectionViewCell, for: indexPath) as! RegularItemCollectionViewCell
        let bookData = booksData[indexPath.row]
        cell.imageView.image = UIImage(systemName: "book")
        if let imageURLString = bookData.imageURL,
           let imageURL = URL(string: imageURLString) {
            cell.imageView.load(url: imageURL)
        }
        cell.titleLabel.text = bookData.title
        cell.addToFavoritesButton.isSelected = bookData.isFavorite
        return cell
    }
}

extension CarouselViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = type else {
            return
        }
        // if indexPath.row == booksData.count + 1 {
        if collectionView.cellForItem(at: indexPath) is SeeMoreCollectionViewCell {
            delegate?.didTapSeeMoreCell(fromCarouselType: type)
        } else {
            delegate?.didTapProductCell(withIndex: indexPath.row, fromCarouselType: type)
        }
    }
}

extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 200
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
