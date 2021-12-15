//
//  CarouselDelegate.swift
//  BookMyBay
//
//  Created by TonyJANG on 14/12/21.
//

import Foundation

protocol CarouselDelegate: AnyObject {
    func didTapProductCell(withIndex index: Int, fromCarouselType carouselType: CarouselType)
    func didTapSeeMoreCell(fromCarouselType carouselType: CarouselType)
}
