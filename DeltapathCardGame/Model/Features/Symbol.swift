//
//  Symbol.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

enum Symbol: String, Comparable {
    static func < (lhs: Symbol, rhs: Symbol) -> Bool {
        return lhs == rhs
    }
    
    case diamond = "Diamond"
    case squiggle = "Squiggle"
    case oval = "Oval"
}
