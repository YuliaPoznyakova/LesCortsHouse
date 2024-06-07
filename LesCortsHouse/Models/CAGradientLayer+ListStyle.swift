//
//  CAGradientLayer+ListStyle.swift
//  LesCortsHouse
//
//  Created by Yulia Poznyakova on 06.06.2024.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: DishListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    private static func colors(for style: DishListStyle) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style {
        case .all:
            beginColor = .blue
            endColor = .white
        case .original:
            beginColor = .green
            endColor = .gray
        case .hot:
            beginColor = .red
            endColor = .brown
        }
        return [beginColor.cgColor, endColor.cgColor]
    }
}
