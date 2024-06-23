//
//  DishStorageManager.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 20.06.2024.
//

import UIKit
import CoreData
import Foundation

public final class DishStorageManager: NSObject {
    public static let shared = DishStorageManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createDish(_ id: UUID, _ title: String, _ notes: String, _ spicy: Bool = false, _ isComplete: Bool = false, _ image: String = "") -> Dish? {
        guard let dishEntityDescription = NSEntityDescription.entity(forEntityName: "Dish", in: context) else {
            return nil
        }
        let dish = Dish(entity: dishEntityDescription, insertInto: context)
        dish.id = id
        dish.title = title
        dish.notes = notes
        dish.spicy = spicy
        dish.isComplete = isComplete
        dish.image = image
        
        appDelegate.saveContext()
        return dish
    }
    
    //читаем Блюда
    public func fetchDishes() -> [Dish] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            return (try? context.fetch(fetchRequest) as? [Dish]) ?? []
        }
    }
    
    //читаем Блюдо
    public func fetchDish(with id: UUID) -> Dish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            guard let dishes = try? context.fetch(fetchRequest) as? [Dish] else {
                return nil
            }
            return dishes.first(where: { $0.id == id })
        }
    }
    
    //обновляем Блюдо
    public func updateDish(_ dish: Dish) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
//            guard let dishes = try? context.fetch(fetchRequest) as? [Dish],
//                  var id = dish.id,
//                  let dish = dishes.first(where: { $0.id == id }) else { return }
//            dish.title = title
//            dish.notes = notes
//            dish.spicy = spicy
//            dish.isComplete = isComplete
//            dish.image = image
            if var dishes = try? context.fetch(fetchRequest) as? [Dish] {
                let index = dishes.indexOfDish(withId: dish.id)
                dishes[index] = dish
            }
        }
        appDelegate.saveContext()
    }
    
    //удаляем все Блюда
    public func deleteAllDishes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            let dishes = try? context.fetch(fetchRequest) as? [Dish]
            dishes?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    //удаляем Блюдо
    public func deleteDish(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            guard let dishes = try? context.fetch(fetchRequest) as? [Dish],
                  let dish = dishes.first(where: { $0.id == id }) else { return }
            context.delete(dish)
        }
        appDelegate.saveContext()
    }
    
    public func addDish(_ dish: Dish) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            var dishes = try? context.fetch(fetchRequest) as? [Dish]
            dishes?.append(dish)
        }
        appDelegate.saveContext()
    }
    
    public func completeDish(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        do {
            guard let dishes = try? context.fetch(fetchRequest) as? [Dish],
                  let dish = dishes.first(where: { $0.id == id }) else { return }
                    dish.isComplete.toggle()
        }
        appDelegate.saveContext()        
    }
    }
    
