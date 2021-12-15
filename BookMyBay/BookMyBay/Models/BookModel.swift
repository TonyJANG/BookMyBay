//
//  BookModel.swift
//  BookMyBay
//
//  Created by TonyJANG on 12/12/21.
//

import Foundation

struct BookModel: Codable {
    let title: String
    let author: String?
    let imageURL: String?
    var isFavorite: Bool = false
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        if let isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite) {
            self.isFavorite = isFavorite
        } else {
            isFavorite = false
        }
    }
}
