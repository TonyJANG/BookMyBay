//
//  HomeViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    let color: UIColor = #colorLiteral(red: 0.4156862745, green: 0.7764705882, blue: 0.8666666667, alpha: 1)
    var booksData: [BookModel]?
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ViewControllerTitles.home
        getProductsData()
        setUpCarousels()
    }
    
    @IBAction func didTapSeeAllProducts(_ sender: UIButton) {
        print("didTapSeeAllProducts")
        showAllProducts()
    }
    
    func getProductsData() {
        booksData = viewModel?.getLocalBooksData()
    }
    
    func showAllProducts() {
        let allProductsViewController = AllProductsViewController(nibName: Constants.Identifier.allProductsViewController, bundle: nil)
        allProductsViewController.viewModel = viewModel
        show(allProductsViewController, sender: nil)
    }
    
    func setUpCarousels() {
        setUpRecommendedCarousel()
    }
    
    func setUpRecommendedCarousel() {
        guard let booksData = booksData else { return }
        let recommendedBooksData = Array(booksData.prefix(20))
        setUpCarousel(withTitle: "Recommended", booksData: recommendedBooksData, shouldShowSeeMoreCellWithTitle: "See all\nrecommended")
        setUpCarousel(withTitle: "Favorites", booksData: recommendedBooksData, shouldShowSeeMoreCellWithTitle: nil)
        setUpCarousel(withTitle: "Recents", booksData: recommendedBooksData, shouldShowSeeMoreCellWithTitle: nil)
    }
    
    func setUpCarousel(withTitle title: String, booksData: [BookModel], shouldShowSeeMoreCellWithTitle seeMoreCellTitle: String?) {
        let carouselViewController = CarouselViewController(nibName: Constants.Identifier.carouselViewController, bundle: nil)
        carouselViewController.setTitle(title)
        carouselViewController.booksData = booksData
        if let seeMoreCellTitle = seeMoreCellTitle {
            carouselViewController.shouldShowSeeMoreCell(withTitle: seeMoreCellTitle)
        }
        addChild(carouselViewController)
        stackView.addArrangedSubview(carouselViewController.view)
        carouselViewController.didMove(toParent: self)
    }
}
