//
//  Roll.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/3/20.
//

import Foundation

public struct Roll {
    var numbers: [Int]
    var isDoublet = false
    public init(numbers: [Int]) {
        var numbers = numbers
        if numbers[0] == numbers[1] {
            self.isDoublet = true
            numbers.append(contentsOf: numbers.map({ 7-$0 }))
        }
        self.numbers = numbers
    }
}

extension Roll {
    public init() {
        let numbers = Array(repeating: Int.random(in: 1...6), count: 2)
        self.init(numbers: numbers)
    }
}

extension Roll {
    public var combinations: Set<Int> {
        let numbers = self.numbers.sorted()
        let range = numbers.startIndex..<numbers.endIndex
        var combinations = Set<Int>()

        var runningTotal: Int
        for index in range {
            runningTotal = 0
            for subIndex in range.suffix(from: index) {
                runningTotal += numbers[subIndex]
                combinations.insert(runningTotal)
            }
        }
        return combinations
    }
}
