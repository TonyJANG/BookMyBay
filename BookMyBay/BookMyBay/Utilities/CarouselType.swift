//
//  CarouselType.swift
//  BookMyBay
//
//  Created by TonyJANG on 14/12/21.
//

import Foundation

enum CarouselType: CaseIterable {
    static var allCases: [CarouselType] { // change order or hide element from here
        [.recommended, .favorite]
    }
    case favorite
    case recent
    case recommended
    case other(title: String, shouldShowSeeMoreCell: Bool, seeMoreCellTitle: String?)
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorites"
        case .recent:
            return "Recents"
        case .recommended:
            return "Recommended"
        case .other(title: let title, shouldShowSeeMoreCell: _, seeMoreCellTitle: _):
            return title
        }
    }
    
    var shouldShowSeeMoreCell: Bool {
        switch self {
        case .recommended:
            return true
        case .favorite, .recent:
            return false
        case .other(title: _, shouldShowSeeMoreCell: let shouldShowSeeMoreCell, seeMoreCellTitle: _):
            return shouldShowSeeMoreCell
        }
    }
    
    var seeMoreCellTitle: String? {
        switch self {
        case .recommended:
            return "See all\nrecommended"
        case .recent, .favorite:
            return nil
        case .other(title: _, shouldShowSeeMoreCell: _, seeMoreCellTitle: let seeMoreCellTitle):
            return seeMoreCellTitle
        }
    }
}
