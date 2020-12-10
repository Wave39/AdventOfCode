//
//  SequenceExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/10/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
    
}
