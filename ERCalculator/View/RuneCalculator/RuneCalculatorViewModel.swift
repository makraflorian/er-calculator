//
//  RuneCalculatorViewModel.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 03..
//

import Foundation
import Combine

class RuneCalculatorViewModel: ObservableObject {

    // MARK: - PROPERTIES
    
    @Published private var calculator = Calculator()
            
    var displayText: String {
        return calculator.displayText
    }
            
    var buttonTypes: [[ButtonType]] {
        [[.digit(.seven), .digit(.eight), .digit(.nine)],
         [.digit(.four), .digit(.five), .digit(.six)],
         [.digit(.one), .digit(.two), .digit(.three)],
         [.digit(.zero), .delete]]
    }
    
    func performAction(for buttonType: ButtonType) {
        switch buttonType {
        case .digit(let digit):
            calculator.setDigit(digit)
        case .delete:
            calculator.delete()
        }
    }
            
}
