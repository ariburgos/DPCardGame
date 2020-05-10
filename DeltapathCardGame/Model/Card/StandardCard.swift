//
//  StandardCard.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

class StandardCard: Card {
    let rank: Rank
    let suit: Suit
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
    
    static func ==(lhs: StandardCard, rhs: StandardCard) -> Bool {
        if lhs.rank == rhs.rank,
            lhs.suit == rhs.suit {
            return true
        }
        return false
    }
}
