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
    
    func updateSnapshot(reloading idsThatChanged: [Dish.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredDishes.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredDishes.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progress = progress
    }
    
    func cellRegistrationHandler(
        cell: UICollectionViewListCell, indexPath: IndexPath, id: Dish.ID) {
        let dish = dish(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = dish.title
        contentConfiguration.secondaryText = dish.notes
        cell.contentConfiguration = contentConfiguration
        
        var dishButtonConfiguration = dishButtonConfiguration(for: dish)
        dishButtonConfiguration.tintColor = .blue
        cell.accessibilityCustomActions = [dishButtonAccessibilityAction(for: dish)]
        cell.accessibilityValue = dish.isComplete ? dishCompletedValue : dishNotCompletedValue
        cell.accessories = [.customView(configuration: dishButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .clear
        cell.backgroundConfiguration = backgroundConfiguration
    }

    func dish(withId id: Dish.ID) -> Dish {
//        let index = dishes.indexOfDish(withId: id)
//        return dishes[index]
        let dishes = DishStorageManager.shared.fetchDishes()
        let index = dishes.indexOfDish(withId: id)
        return dishes[index]
        
    }

    func updateDish(_ dish: Dish) {
//        let index = dishes.indexOfDish(withId: dish.id)
//        dishes[index] = dish
        DishStorageManager.shared.updateDish(dish)
    }

    func completeDish(withId id: Dish.ID) {
//        let dish = dish(withId: id)
//        dish.isComplete.toggle()
        DishStorageManager.shared.completeDish(with: id)
//        updateDish(dish)
    }
    
    func addDish(_ dish: Dish) {
//        dishes.append(dish)
        DishStorageManager.shared.addDish(dish)
    }
    
    func deleteDish(withId id: Dish.ID) {
//        let index = dishes.indexOfDish(withId: id)
//        dishes.remove(at: index)
        DishStorageManager.shared.deleteDish(with: id)
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
