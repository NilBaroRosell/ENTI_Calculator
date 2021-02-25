//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Guillermo Fernandez on 24/02/2021.
//

import Foundation
import SwiftUI
import Combine

enum CalculatorOperation {
    case none
    case swipeSign
    case percentage
    case division
    case multiplication
    case subtraction
    case addition
    case equal
}

protocol CalculatorViewModelProtocol {
    func addDigit(_ digit: String)
    func resetOperands()
}

class CalculatorViewModel: CalculatorViewModelProtocol,
                           ObservableObject {
    
    @Published var display: String = "0"
    @Published var buttonText: String = "AC"

    private var operation: Calculation = Calculation(firstOperator: 0,
                                                     secondOperator: 0,
                                                     operation: .none)
    private var operationFinished: Bool = false
    
    public func addDigit(_ digit: String) {
        self.buttonText = "C"
        if self.operation.operation != .none && self.operation.secondOperator == nil {
            self.operation.secondOperator = 0
            self.display = digit
            return
        }
        guard self.display != "0" else {
            self.display = digit
            return
        }
                
        guard self.display.count < 6 else {
            return
        }
        
        self.display += digit        
    }
    
    public func resetOperands() {
        if self.buttonText == "AC"
        {
            self.operation.reset()
        }
        else if self.buttonText == "C"
        {
            self.buttonText = "AC"
        }
        self.display = "0"
    }
    
    public func perform(operation: CalculatorOperation) {
        guard let value = Double(display) else { return }
        
        switch operation {
        case .swipeSign:
            self.display = String(-value)
        case .equal:
            self.operation.secondOperator = value
            guard let result = calculateResult(for: self.operation) else { return }
            self.display = String(format: "%0.2f", result)
            self.operation.reset()
            self.operation.firstOperator = result
            self.operationFinished = true
            return
        default:
            self.operation.firstOperator = value
            self.operation.operation = operation
        }
        
        self.display = "0"
    }
    
    func calculateResult(for values: Calculation) -> Double? {
        guard let secondOperator = values.secondOperator else { return nil }
        switch values.operation {
        case .addition:
            return operation.firstOperator + secondOperator
        case .division:
            return operation.firstOperator / secondOperator
        case .multiplication:
            return operation.firstOperator * secondOperator
        case .subtraction:
            return operation.firstOperator - secondOperator
        case .percentage:
            let base = Double(secondOperator)
            let percentage = Double(operation.firstOperator) / 100
            let result = base * percentage
            return result
        default:
            return nil
        }
    }
}
