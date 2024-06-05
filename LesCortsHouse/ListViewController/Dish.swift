//
//  Dish.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 29.04.2024.
//

import Foundation

struct Dish: Equatable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var image: String = ""
    var description: String = ""
    var spicy: Bool = false
    var isComplete: Bool = false
}

extension [Dish] {
    func indexOfDish(withId id: Dish.ID) -> Self.Index {
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG

extension Dish {
    static var sampleData = [
        Dish (title: "Пицка", image: "ин прогресс", description: "Если лень готовить, то пойдет!", spicy: true),
        Dish (title: "Чкмерули", image: "ин прогресс", description: "Классика!", spicy: true, isComplete: true),
        Dish (title: "Утка", image: "ин прогресс", description: "Вкусная, но подгорела.", spicy: false),
        Dish (title: "Жареная рыба", image: "ин прогресс", description: "С луком.", spicy: true),
        Dish (title: "Паэлья", image: "ин прогресс", description: "С морепродуктами.", spicy: false, isComplete: true),
        Dish (title: "Пиво", image: "ин прогресс", description: "Без этого никак.", spicy: false)
    ]
}

#endif
