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
}
