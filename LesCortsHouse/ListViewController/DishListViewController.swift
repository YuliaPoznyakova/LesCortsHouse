//
//  ViewController.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 29.04.2024.
//

import UIKit

class DishListViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    var dishes: [Dish] = Dish.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Dish.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dishes.map { $0.title })
        dataSource.apply(snapshot)
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(
        _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        let id = dishes[indexPath.item].id
        pushDetailListViewForDish(withId: id)
        return false
    }
    
    func pushDetailListViewForDish(withId id: Dish.ID) {
        let dish = dish(withId: id)
        let viewController = DishViewController(dish: dish) { [weak self] dish in
            self?.updateDish(dish)
            self?.updateSnapshot(reloading: [dish.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .cyan
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

