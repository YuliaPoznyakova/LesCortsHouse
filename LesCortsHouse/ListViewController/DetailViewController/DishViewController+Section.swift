//
//  DishViewController+Section.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 24.05.2024.
//

import Foundation

extension DishViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case description
        
        var name: String {
            switch self {
            case .view: return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .description:
                return NSLocalizedString("Description", comment: "Description section name")
            }
        }
    }
}
