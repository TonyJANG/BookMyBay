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
    var booksData: [BookModel]?
    weak var delegate: ViewModelDelegate?
    
    convenience init(delegate: ViewModelDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func getBooksData() {
        guard let url = URL(string: Constants.URL.booksDataURL) else {
            DispatchQueue.main.async {
                self.delegate?.didGet(booksData: nil, errorMessage: Constants.ErrorMessages.invalidURL)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
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
}
