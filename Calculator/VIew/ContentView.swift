//
//  ContentView.swift
//  Calculator
//
//  Created by Guillermo Fernandez on 24/02/2021.
//

import SwiftUI

struct ContentView: View {
    let buttons = [
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"],
    ]
    
    @ObservedObject var viewModel = CalculatorViewModel()
    
    @State var operandText = "0"
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Text(self.viewModel.display)
                        .font(Font.custom("SFUIDisplay", size: 70))
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 270, height: 100, alignment: .trailing)
                    VStack {
                        HStack {
                            ActionButton(label: self.viewModel.buttonText) { self.viewModel.resetOperands() }
                            ActionButton(label: "⁺/₋") { self.viewModel.perform(operation: .swipeSign)}
                            ActionButton(label: "%") { self.viewModel.perform(operation: .percentage)}
                            OperationButton(label: "÷") { self.viewModel.perform(operation: .division)}
                        }
                        HStack {
                            DigitButton(label: "7", viewModel: self.viewModel)
                            DigitButton(label: "8", viewModel: self.viewModel)
                            DigitButton(label: "9", viewModel: self.viewModel)
                            OperationButton(label: "✕") { self.viewModel.perform(operation: .multiplication)}
                        }
                        HStack {
                            DigitButton(label: "4", viewModel: self.viewModel)
                            DigitButton(label: "5", viewModel: self.viewModel)
                            DigitButton(label: "6", viewModel: self.viewModel)
                            OperationButton(label: "−")  { self.viewModel.perform(operation: .subtraction)}
                        }
                        HStack {
                            DigitButton(label: "1", viewModel: self.viewModel)
                            DigitButton(label: "2", viewModel: self.viewModel)
                            DigitButton(label: "3", viewModel: self.viewModel)
                            OperationButton(label: "+") { self.viewModel.perform(operation: .addition)}
                        }
                        HStack {
                            LongDigitButton(label: "0", viewModel: self.viewModel)
                            DigitButton(label: ",",  viewModel: self.viewModel)
                            OperationButton(label: "=")  { self.viewModel.perform(operation: .equal)}
                        }

                    }
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
