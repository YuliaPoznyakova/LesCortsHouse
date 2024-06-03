//
//  DishListViewController+Actions.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 30.04.2024.
//

import UIKit

extension DishListViewController {
    @objc func didPressDishCheckBoxButton(_ sender: DishCheckBoxButton) {
        guard let id = sender.id else { return }
        completeDish(withId: id)
    }
    
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let dish = Dish(title: "")
        let viewController = DishViewController(dish: dish) { [weak self] dish in
            self?.addDish(dish)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        viewController.isAddingNewDish = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString("Add Dish", comment: "Add Dish view controller title")
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
