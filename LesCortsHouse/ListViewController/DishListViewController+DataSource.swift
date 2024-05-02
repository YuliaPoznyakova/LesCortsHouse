//
//  DishListViewController+DataSource.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 30.04.2024.
//

import UIKit

extension DishListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Dish.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Dish.ID>
    
    var dishCompletedValue: String {
        NSLocalizedString("Completed", comment: "Dish completed value")
    }
    
    var dishNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Dish not completed value")
    }
    
    func updateSnapshot(reloading ids: [Dish.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dishes.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(
        cell: UICollectionViewListCell, indexPath: IndexPath, id: Dish.ID) {
        let dish = dish(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = dish.title
        contentConfiguration.secondaryText = dish.description
        cell.contentConfiguration = contentConfiguration
        
        var dishButtonConfiguration = dishButtonConfiguration(for: dish)
        dishButtonConfiguration.tintColor = .blue
        cell.accessibilityCustomActions = [dishButtonAccessibilityAction(for: dish)]
        cell.accessibilityValue = dish.isComplete ? dishCompletedValue : dishNotCompletedValue
        cell.accessories = [.customView(configuration: dishButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .cyan
        cell.backgroundConfiguration = backgroundConfiguration
    }

    func dish(withId id: Dish.ID) -> Dish {
        let index = dishes.indexOfDish(withId: id)
        return dishes[index]
    }

    func updateDish(_ dish: Dish) {
        let index = dishes.indexOfDish(withId: dish.id)
        dishes[index] = dish
    }

    func completeDish(withId id: Dish.ID) {
        var dish = dish(withId: id)
        dish.isComplete.toggle()
        updateDish(dish)
    }

    private func dishButtonAccessibilityAction(for dish: Dish) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Dish done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeDish(withId: dish.id)
            return true
        }
        return action
    }

    private func dishButtonConfiguration(for dish: Dish) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = dish.isComplete ? "circle.fill": "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = DishCheckBoxButton()
        button.addTarget(self, action: #selector(didPressDishCheckBoxButton(_:)), for: .touchUpInside)
        button.id = dish.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}