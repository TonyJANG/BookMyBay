//
//  InitialLoadingViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit

class InitialLoadingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel: ViewModel?
    
    private var hasFinishedPresentation = false {
        didSet {
            if shouldPresentHome {
                presentHome()
            }
        }
    }
    private var hasSuccessfullyObtainedData = false {
        didSet {
            if shouldPresentHome {
                presentHome()
            }
        }
    }
    private var shouldPresentHome: Bool {
        hasFinishedPresentation && hasSuccessfullyObtainedData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hasFinishedPresentation = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicatorView.stopAnimating()
    }
    
    func setUpViewModel() {
        if viewModel == nil {
            viewModel = ViewModel(delegate: self)
        }
        viewModel?.getBooksData()
    }
    
    func presentHome() {
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeViewController.modalPresentationStyle = .fullScreen
        homeViewController.modalTransitionStyle = .crossDissolve
        present(homeViewController, animated: true) {
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension InitialLoadingViewController: ViewModelDelegate {
    func didGet(booksData: [BookModel]?, errorMessage: String?) {
        if let errorMessage = errorMessage {
            titleLabel.isHidden = true
            subtitleLabel.text = errorMessage + "\n" + Constants.ErrorMessages.tryAgainLater
            activityIndicatorView.stopAnimating()
        } else if booksData != nil {
            hasSuccessfullyObtainedData = true
        }
    }
}
