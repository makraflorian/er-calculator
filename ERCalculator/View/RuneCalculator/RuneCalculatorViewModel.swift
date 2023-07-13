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
    
    @Published var displayText: String = "0"
    @Published var resultText: String = "0"
    @Published var currentText: String = "0"
    @Published var aboveText: String = "0"
    private var newNumber: Decimal?
    private var result_dec: Decimal?
    
    private var number: Decimal? {
        newNumber
    }
    
    // MARK: - OPERATIONS
    func setDigit(_ digit: Digit) {
        guard canAddDigit(digit) else { return }
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        //        displayText = getNumberString(forNumber: number, withCommas: true)
        //        calc()
    }
    
    func delete() {
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: String(numberString.dropLast()))
        //        displayText = getNumberString(forNumber: number, withCommas: true)
        //        calc()
    }
    
    func calc() {
        
        /// Get the last level up rune amount
        let runes_got = NSDecimalNumber(decimal: number ?? 0.0).doubleValue
        let runes = runes_got / 4.0 * 100.0
        print("RUNES = \(runes)")
        
        /// Get the rough level value based on the more precise DS3 formula
        let guess = cubicSolve(a: 0.02, b: 3.05, c: 105.6, d: -895.0 - runes)
        var result = guess
        print("GUESS = \(guess)")
        //        let res1 = cubicSolve(a: -0.02, b: -3.12, c: -111.78, d: -786.32 + runes) // ER formula
        
        /// Calculate the required runes for the guessed level and corrects the result based on this checks
        let helper_current = floor(runesForLevel(guess: guess) / 100.0 * 4.0)
        let helper_above = floor(runesForLevel(guess: guess + 1.0) / 100.0 * 4.0)
        print("CURRENT = \(helper_current)")
        if helper_current > floor(runes_got) {
            result = guess - 1.0
        } else if helper_above <= floor(runes_got){
            result = guess + 1.0
        } else {
            result = guess
        }
        //        let helper = ((((guess_helper-11)*0.02)+0.1) * (pow(guess_helper + 81), 2)) + 1 // ER formula
        
        /// Calculate the helpers (under arnd above levels rune requirement)
        let current_souls = (runesForLevel(guess: result) / 100.0) * 4.0
        let above_souls = (runesForLevel(guess: (result + 1.0)) / 100.0) * 4.0
        
        /// Set the published variables
        currentText = getNumberString(forNumber: Decimal(floor(current_souls)), withCommas: true)
        aboveText = getNumberString(forNumber: Decimal(floor(above_souls)), withCommas: true)
        resultText = getNumberString(forNumber: Decimal(floor(result)), withCommas: true)
    }
    
    // MARK: - HELPERS
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        return (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return (number != nil || digit != .zero) && getNumberString(forNumber: newNumber).count < 10
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
            setDigit(digit)
        case .delete:
            delete()
        }
        displayText = getNumberString(forNumber: number, withCommas: true)
        calc()
    }
    
    
}
