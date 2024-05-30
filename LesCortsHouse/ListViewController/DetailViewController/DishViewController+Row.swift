//
//  ReminderViewController+Row.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 23.05.2024.
//

import UIKit

extension DishViewController {
    enum Row: Hashable {
        case header(String)
        case title
        case description
        case editableText(String?)
        
        var imageName: String? {
            switch self {
            case .title: return "name"
            case .description: return "content"
            default: return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}