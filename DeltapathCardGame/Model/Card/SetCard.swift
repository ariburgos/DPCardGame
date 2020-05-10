//
//  SetCard.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

class SetCard: Card {
    let number: Number
    let symbol: Symbol
    let shading: Shading
    let color: Color
    
    init(number: Number, symbol: Symbol, shading: Shading, color: Color) {
        self.number = number
        self.symbol = symbol
        self.shading = shading
        self.color = color
    }
    
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        if lhs.number == rhs.number,
            lhs.symbol == rhs.symbol,
            lhs.shading == rhs.shading,
            lhs.color == rhs.color {
            return true
        }
        return false
    }
}
