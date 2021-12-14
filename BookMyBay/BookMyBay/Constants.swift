//
//  Constants.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import Foundation

enum Constants {
    enum ErrorMessages {
        static let decodingError = "Decoding error."
        static let invalidURL = "Invalid URL."
        static let serviceError = "Service error."
        static let tryAgainLater = "Please try again later."
        static let unexpectedError = "Unexpected error"
    }
    enum URL {
        static let booksDataURL = "https://de-coding-test.s3.amazonaws.com/books.json"
    }
    enum ViewControllerTitles {
        static let home = "Home"
        static let allProducts = "All the books"
    }
    enum Identifier {
        static let regularItemCollectionViewCell = "RegularItemCollectionViewCell"
    }
}
