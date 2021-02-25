//
//  Operation.swift
//  Calculator
//
//  Created by Guillermo Fernandez on 25/02/2021.
//

import Foundation

struct Calculation {
    var firstOperator: Double
    var secondOperator: Double?
    var operation: CalculatorOperation
    
    mutating func reset() {
        self.firstOperator = 0.0
        self.secondOperator = nil
        self.operation = .none
    }
}
