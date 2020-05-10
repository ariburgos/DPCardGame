//
//  Shading.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

enum Shading: String, Comparable {
    static func < (lhs: Shading, rhs: Shading) -> Bool {
        return lhs == rhs
    }
    
    case striped = "Striped"
    case solid = "Solid"
    case open = "Open"
}
