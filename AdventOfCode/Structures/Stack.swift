//
//  Stack.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Stack<T> {
    var array: [T] = []

    mutating func push(_ element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        if !array.isEmpty {
            let index = array.count - 1
            let poppedValue = array.remove(at: index)
            return poppedValue
        } else {
            return nil
        }
    }
    
    func peek() -> T? {
        if !array.isEmpty {
            return array.last
        } else {
            return nil
        }
    }
    
}
