//
//  LoadImageURLImageView.swift
//  BookMyBay
//
//  Created by TonyJANG on 13/12/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
}
