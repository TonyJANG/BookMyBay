//
//  AllProductsViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class AllProductsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var booksData: [BookModel]?
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getProductsData()
    }
    
    func setUpView() {
        title = Constants.ViewControllerTitles.allProducts
        collectionView.register(UINib(nibName: Constants.Identifier.regularItemCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Identifier.regularItemCollectionViewCell)
    }
    
    func getProductsData() {
        booksData = viewModel?.getLocalBooksData()
    }
}

extension AllProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.regularItemCollectionViewCell, for: indexPath) as! RegularItemCollectionViewCell
        let bookData = booksData![indexPath.row]
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

extension AllProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // code
    }
}

extension AllProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 60) / 2
        let height: CGFloat = width * 3/2
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
