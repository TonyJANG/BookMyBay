//
//  ModalDetailViewController.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import UIKit
import SafariServices

class ModalDetailViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var titleText: String?
    private var descriptionText: String?
    private var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 10
        updateViewValues()
    }
    
    func set(title: String, description: String?, imageURL: String?) {
        titleText = title
        descriptionText = description
        self.imageURL = imageURL
        if view != nil {
            updateViewValues()
        }
    }
    
    private func updateViewValues() {
        if let titleText = titleText {
            titleLabel.text = titleText
        } else {
            titleLabel.isHidden = true
        }
        if let descriptionText = descriptionText {
            descriptionLabel.text = descriptionText
        } else {
            descriptionLabel.isHidden = true
        }
        if let imageURLString = imageURL,
           let imageURL = URL(string: imageURLString) {
            imageView.load(url: imageURL)
        } else {
            imageView.isHidden = true
        }
    }
    
    @IBAction func didTapOutsideContainer(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapEBayButton(_ sender: UIButton) {
        var eBayURL: URL?
        let rawURLString = "https://www.ebay.com/sch/\(titleText ?? "")"
        if let urlString = rawURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            eBayURL = url
        } else if let url = URL(string: "https://www.ebay.com") {
            eBayURL = url
        }
        guard let eBayURL = eBayURL else {
            return
        }
        let safariConfiguration = SFSafariViewController.Configuration()
        safariConfiguration.entersReaderIfAvailable = true
        let safariViewController = SFSafariViewController(url: eBayURL, configuration: safariConfiguration)
        present(safariViewController, animated: true)
    }
    
    @IBAction func didTapAmazonButton(_ sender: UIButton) {
        var amazonURL: URL?
        let rawURLString = "https://www.amazon.com/s?k=\(titleText ?? "")"
        if let urlString = rawURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            amazonURL = url
        } else if let url = URL(string: "https://www.amazon.com") {
            amazonURL = url
        }
        guard let amazonURL = amazonURL else {
            return
        }
        UIApplication.shared.open(amazonURL)
    }
}

extension ModalDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard touch.view != containerView,
              touch.view != closeButton,
              !containerView.bounds.contains(touch.location(in: containerView)),
              !closeButton.bounds.contains(touch.location(in: containerView))
        else {
            return false
        }
        return true
    }
}
