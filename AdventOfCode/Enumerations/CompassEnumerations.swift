//
//  CompassEnumerations.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/11/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public enum CompassDirection: Hashable {
    case North
    case East
    case South
    case West
    case NorthEast
    case NorthWest
    case SouthEast
    case SouthWest

    var step: Point2D {
        switch self {
        case .North: return Point2D(x: 0, y: -1)
        case .South: return Point2D(x: 0, y: 1)
        case .East: return Point2D(x: 1, y: 0)
        case .West: return Point2D(x: -1, y: 0)
        case .NorthEast: return Point2D(x: 1, y: -1)
        case .NorthWest: return Point2D(x: -1, y: -1)
        case .SouthEast: return Point2D(x: 1, y: 1)
        case .SouthWest: return Point2D(x: -1, y: 1)
        }
    }

    public static func AllDirections() -> [CompassDirection] {
        [ NorthWest, North, NorthEast, East, SouthEast, South, SouthWest, West ]
    }

    public static let orthogonal: [CompassDirection] = [ .North, .West, .South, .East ]

    public func TurnLeft() -> CompassDirection {
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

    public func TurnRight() -> CompassDirection {
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

    public func OffsetFromOrigin() -> Point2D {
        if self == .North {
            return Point2D(x: 0, y: -1)
        } else if self == .West {
            return Point2D(x: -1, y: 0)
        } else if self == .South {
            return Point2D(x: 0, y: 1)
        } else if self == .East {
            return Point2D(x: 1, y: 0)
        } else if self == .NorthEast {
            return Point2D(x: 1, y: -1)
        } else if self == .NorthWest {
            return Point2D(x: -1, y: -1)
        } else if self == .SouthEast {
            return Point2D(x: 1, y: 1)
        } else {
            return Point2D(x: -1, y: 1)
        }
    }

    public func MovingHorizontally() -> Bool {
        return self == .West || self == .East
    }

    public func MovingVertically() -> Bool {
        return self == .North || self == .South
    }
}
