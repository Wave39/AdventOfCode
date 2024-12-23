//
//  InputError.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/23/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//


struct InputError: Error {
    var message: String
    
    static let invalid = InputError(message: "Invalid input")
}
