//
//  DishListStyle.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 03.06.2024.
//

import Foundation

enum DishListStyle: Int {
    case hot
    case original
    case all
    
    var name: String {
        switch self {
        case .hot:
            return NSLocalizedString("Hot", comment: "Hot style name")
        case .original:
            return NSLocalizedString("Original", comment: "Original style name")
        case .all:
            return NSLocalizedString("All", comment: "All style name")
        }
    }
    
    func shouldInclude(spicy: Bool) -> Bool {
        switch self {
        case .hot:
            return spicy
        case .original:
            return !spicy
        case .all:
            return true
        }
    }
}
