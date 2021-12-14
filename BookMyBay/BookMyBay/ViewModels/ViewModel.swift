//
//  ViewModel.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func didGet(booksData: [BookModel]?, errorMessage: String?)
}

class ViewModel {
    private var booksData: [BookModel]? {
        didSet {
            // notification
        }
    }
    weak var delegate: ViewModelDelegate?
    
    convenience init(delegate: ViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func getBooksData() {
        if Thread.isMainThread {
            DispatchQueue.global().async {
                self._getBooksData()
            }
        } else {
            _getBooksData()
        }
    }
    
    private func _getBooksData() {
        guard let url = URL(string: Constants.URL.booksDataURL) else {
            DispatchQueue.main.async {
                self.delegate?.didGet(booksData: nil, errorMessage: Constants.ErrorMessages.invalidURL)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            var booksData: [BookModel]?
            var errorMessage: String?
            if let error = error {
                print(error)
                errorMessage = Constants.ErrorMessages.serviceError
            } else if let data = data {
                do {
                    booksData = try JSONDecoder().decode([BookModel].self, from: data)
                } catch let decodingError {
                    print(decodingError)
                    errorMessage = Constants.ErrorMessages.decodingError
                }
            } else {
                errorMessage = Constants.ErrorMessages.unexpectedError
            }
            self.booksData = booksData
            DispatchQueue.main.async {
                self.delegate?.didGet(booksData: booksData, errorMessage: errorMessage)
            }
        }.resume()
    }
    
    func getLocalBooksData() -> [BookModel]? {
        return booksData
    }
}
