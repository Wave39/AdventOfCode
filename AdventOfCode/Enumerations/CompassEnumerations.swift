//
//  CompassEnumerations.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/11/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

enum CompassDirection {
    case North
    case East
    case South
    case West
    
    func TurnLeft() -> CompassDirection {
        if self == .North {
            return .West
        } else if self == .West {
            return .South
        } else if self == .South {
            return .East
        } else {
            return .North
        }
    }
    
    func TurnRight() -> CompassDirection {
        if self == .North {
            return .East
        } else if self == .East {
            return .South
        } else if self == .South {
            return .West
        } else {
            return .North
        }
    }
}

