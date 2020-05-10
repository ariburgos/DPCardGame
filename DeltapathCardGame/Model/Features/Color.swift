//
//  Color.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

enum Color: Comparable {    
    static func < (lhs: Color, rhs: Color) -> Bool {
        return lhs == rhs
    }
    
    case red
    case blue
    case green
}
