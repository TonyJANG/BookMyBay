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
    
    func setUpCarousels() {
        setUpRecommendedCarousel()
    }
    
    func setUpRecommendedCarousel() {
        guard let booksData = booksData else { return }
        let recommendedBooksData = Array(booksData.prefix(10))
        for carouselType in CarouselType.allCases {
            setUpCarousel(ofType: carouselType, data: recommendedBooksData)
        }
    }
    
    func setUpCarousel(ofType type: CarouselType, data: [BookModel]) {
        let carouselViewController = CarouselViewController(nibName: Constants.Identifier.carouselViewController, bundle: nil)
        carouselViewController.type = type
        carouselViewController.booksData = data
        carouselViewController.delegate = self
        addChild(carouselViewController)
        stackView.addArrangedSubview(carouselViewController.view)
        carouselViewController.didMove(toParent: self)
    }
    
    func showAllProducts() {
        let allProductsViewController = AllProductsViewController(nibName: Constants.Identifier.allProductsViewController, bundle: nil)
        allProductsViewController.viewModel = viewModel
        show(allProductsViewController, sender: nil)
    }
    
    func showProductDetail(withData data: BookModel) {
        let modalDetailViewController = ModalDetailViewController(nibName: Constants.Identifier.modalDetailViewController, bundle: nil)
        modalDetailViewController.set(title: data.title, description: data.author, imageURL: data.imageURL)
        modalDetailViewController.modalPresentationStyle = .overFullScreen
        modalDetailViewController.modalTransitionStyle = .crossDissolve
        present(modalDetailViewController, animated: true)
    }
}

extension HomeViewController: CarouselDelegate {
    func didTapProductCell(withIndex index: Int, fromCarouselType carouselType: CarouselType) {
        print("didTapProductCell(withIndex: \(index), fromCarouselType: \(carouselType)")
        guard let booksData = booksData,
              index < booksData.count
        else {
            return
        }
        showProductDetail(withData: booksData[index])
    }
    
    func didTapSeeMoreCell(fromCarouselType carouselType: CarouselType) {
        print("didTapSeeMoreCell(fromCarouselType: \(carouselType)")
        showAllProducts()
    }
}
