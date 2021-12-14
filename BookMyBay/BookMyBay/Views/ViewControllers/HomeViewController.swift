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
    }
}
