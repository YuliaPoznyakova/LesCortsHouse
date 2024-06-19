//
//  DishViewConroller.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 23.05.2024.
//

import UIKit

class DishViewController: UICollectionViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var dish: Dish {
        didSet {
            onChange(dish)
        }
    }
    var workingDish: Dish
    var isAddingNewDish = false
    var onChange: (Dish) -> Void
    private var dataSource: DataSource!
    
    init(dish: Dish, onChange: @escaping (Dish) -> Void) {
        self.dish = dish
        self.workingDish = dish
        self.onChange = onChange
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize DishViewController using init(dish:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Dish", comment: "Dish view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
        updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            if isAddingNewDish {
                onChange(workingDish)
            } else {
                prepareForViewing()
            }
        }
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.textFieldEditing, .editableText(let title, _)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case (.textViewEditing, .editableText(let description, _)):
            cell.contentConfiguration = descriptionConfiguration(for: cell, with: description)
        default:
            fatalError("Unexpected combination of section and row.")
        }
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.textFieldEditing, .textViewEditing])
        snapshot.appendItems([.header(Section.textFieldEditing.name), .editableText(dish.title, id: Section.textFieldEditing.name)], toSection: .textFieldEditing)
        snapshot.appendItems([.header(Section.textViewEditing.name), .editableText(dish.description, id: Section.textViewEditing.name)], toSection: .textViewEditing)
        dataSource.apply(snapshot)
    }
    
    @objc func didCancelEdit() {
        workingDish = dish
        setEditing(false, animated: true)
    }
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        if workingDish != dish {
            dish = workingDish
        }
        updateSnapshotForViewing()
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([
            Row.header(""),
            Row.title,
            Row.description
        ], toSection: .view)
//        snapshot.appendItems([
//            Row.title,
//            Row.description
//        ], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
