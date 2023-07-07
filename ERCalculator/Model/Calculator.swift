//
//  Calculator.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 07..
//

import Foundation

struct Calculator {
    
    // MARK: - PROPERTIES
    private var newNumber: Decimal?
    private var result: Decimal?
    
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    private var number: Decimal? {
        newNumber
    }
    
    // MARK: - OPERATIONS
    mutating func setDigit(_ digit: Digit) {
        guard canAddDigit(digit) else { return }
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
    }
    
    mutating func delete() {
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: String(numberString.dropLast()))
    }
    
    // MARK: - HELPERS
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        return (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return (number != nil || digit != .zero) && getNumberString(forNumber: newNumber).count < 10
    }
}
