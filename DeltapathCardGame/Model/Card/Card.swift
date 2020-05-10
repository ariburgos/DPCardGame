//
//  Card.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

class Card : Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        if let left = lhs as? StandardCard,
            let right = rhs as? StandardCard {
            return left == right
        }
        if let left = lhs as? SetCard,
            let right = rhs as? SetCard {
            return left == right
        }
        return false
    }
}




