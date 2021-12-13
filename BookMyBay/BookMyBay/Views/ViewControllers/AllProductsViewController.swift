//
//  AllProductsViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class AllProductsViewController: UIViewController {
    
    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ViewControllerTitles.allProducts
    }
}
