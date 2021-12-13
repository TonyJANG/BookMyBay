//
//  HomeViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ViewControllerTitles.home
    }
    
    @IBAction func didTapSeeAllProducts(_ sender: UIButton) {
        print("didTapSeeAllProducts")
        showAllProducts()
    }
    
    func showAllProducts() {
        let allProductsViewController = AllProductsViewController(nibName: "AllProductsViewController", bundle: nil)
        allProductsViewController.viewModel = viewModel
        show(allProductsViewController, sender: nil)
//        navigationController?.show(allProductsViewController, sender: nil)
    }
}
