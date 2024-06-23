//
//  Dish.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 29.04.2024.
//

import CoreData
import Foundation

//struct Dish: Equatable, Identifiable {
//    var id: String = UUID().uuidString
//    var title: String
//    var image: String = ""
//    var notes: String = ""
//    var spicy: Bool = false
//    var isComplete: Bool = false
//}

extension [Dish] {
    func indexOfDish(withId id: Dish.ID) -> Self.Index {
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        return index
    }
}

//#if DEBUG
//
//extension Dish {
//    static var sampleData = [
//        Dish (title: "Пицка", image: "ин прогресс", notes: "Если лень готовить, то пойдет!", spicy: true),
//        Dish (title: "Чкмерули", image: "ин прогресс", notes: "Классика!", spicy: true, isComplete: true),
//        Dish (title: "Утка", image: "ин прогресс", notes: "Вкусная, но подгорела.", spicy: false),
//        Dish (title: "Жареная рыба", image: "ин прогресс", notes: "С луком.", spicy: true),
//        Dish (title: "Паэлья", image: "ин прогресс", notes: "С морепродуктами.", spicy: false, isComplete: true),
//        Dish (title: "Пиво", image: "ин прогресс", notes: "Без этого никак.", spicy: false)
//    ]
//}
//
//#endif
