//
//  Suit.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

enum Suit: String, Comparable {
    static func < (lhs: Suit, rhs: Suit) -> Bool {
        return lhs == rhs
    }
    
    case spades = "♠"
    case hearts = "♥"
    case diamonds = "♦"
    case clubs = "♣"
}
