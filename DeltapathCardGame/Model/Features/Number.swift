//
//  Number.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

enum Number: String, Comparable {
    static func < (lhs: Number, rhs: Number) -> Bool {
        return lhs == rhs
    }
    
    case one = "One"
    case two = "Two"
    case three = "Three"
}
