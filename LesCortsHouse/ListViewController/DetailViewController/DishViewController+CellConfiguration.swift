//
//  DishViewController+CellConfiguration.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 28.05.2024.
//

import UIKit

extension DishViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row)
    -> UIListContentConfiguration
    {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String)
    -> UIListContentConfiguration
    {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?)
    -> TextFieldContentView.Configuration
    {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        contentConfiguration.onChange = { [weak self] title in
            self?.workingDish.title = title
        }
        return contentConfiguration
    }
    
    func descriptionConfiguration(for cell: UICollectionViewListCell, with description: String?)
    -> TextViewContentView.Configuration
    {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = description
        contentConfiguration.onChange = { [weak self] description in
            self?.workingDish.description = description
        }
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .title: return dish.title
        case .description: return dish.description
        default: return nil
        }
    }
}

