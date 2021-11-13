//
//  DoubleExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/11/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Double {
    public func toString() -> String {
        String(format: "%.5f", self)
    }
}
