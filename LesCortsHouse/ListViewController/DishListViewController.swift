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
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .cyan
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

