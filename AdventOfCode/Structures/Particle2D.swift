//
//  Particle2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Particle2D: Hashable {
    var x: Int = 0
    var y: Int = 0
    var deltaX: Int = 0
    var deltaY: Int = 0

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(deltaX)
        hasher.combine(deltaY)
    }

    var description: String {
        return "(\(x),\(y)) -> (\(deltaX),\(deltaY))"
    }

    static func == (lhs: Particle2D, rhs: Particle2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.deltaX == rhs.deltaX && lhs.deltaY == rhs.deltaY
    }

    static func boundingRectangle(arr: [Particle2D]) -> Rect2D {
        var retval = Rect2D()
        retval.x1 = Int.max
        retval.y1 = Int.max
        retval.x2 = Int.min
        retval.y2 = Int.min
        
        for p in arr {
            if p.x < retval.x1 {
                retval.x1 = p.x
            }
            
            if p.y < retval.y1 {
                retval.y1 = p.y
            }
            
            if p.x > retval.x2 {
                retval.x2 = p.x
            }
            
            if p.y > retval.y2 {
                retval.y2 = p.y
            }
        }
        
        return retval
    }
    
    static func gridString(arr: [Particle2D]) -> String {
        let bounds = boundingRectangle(arr: arr)
        var grid: [[Bool]] = []
        for _ in bounds.y1...bounds.y2 {
            var gridRow: [Bool] = []
            for _ in bounds.x1...bounds.x2 {
                gridRow.append(false)
            }
            
            grid.append(gridRow)
        }
        
        for p in arr {
            grid[p.y - bounds.y1][p.x - bounds.x1] = true
        }
        
        var retval = ""
        for y in 0...(bounds.y2 - bounds.y1) {
            for x in 0...(bounds.x2 - bounds.x1) {
                retval += (grid[y][x] ? "#" : ".")
            }
            
            retval += "\n"
        }

        return retval
    }
    
}
