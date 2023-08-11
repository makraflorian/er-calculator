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
    
    @Published var resultLevel: Int = 0
    
    @Published var selectedPlayer = PlayerType.invader
    @Published var selectedEnemy = (PlayerType.friendly + PlayerType.enemy)[1]
    @Published var selectionEnemyArray = PlayerType.friendly + PlayerType.enemy
    
    private var newNumber: Decimal?
    
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
    
    ///eh, not the best
    func clearAll(buttonType: ButtonType) {
        if buttonType == .delete {
            newNumber = 0
            displayText = "0"
            calc()
        }
    }
    
    func changePlayer() {
        if PlayerType.friendly.contains(selectedPlayer) {
            selectionEnemyArray = PlayerType.enemy
            selectedEnemy = PlayerType.enemy[0]
        } else {
            selectionEnemyArray = PlayerType.friendly + PlayerType.enemy
        }
    }
    
    func calc() {
        
        let multiplier = getPercent(player: selectedPlayer, enemy: selectedEnemy)
        
        var result = getLevel(number: number ?? 0.0, multiplier: multiplier)
        
        if result < 1.0 { result = 1.0 }
        
        resultLevel = Int(floor(result))
        
        /// Calculate the helpers (under and above levels rune requirement)
        let current_souls = runesForLevel(guess: result) * multiplier
        let above_souls = runesForLevel(guess: (result + 1.0)) * multiplier
        
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
        return (number != nil || digit != .zero) && getNumberString(forNumber: newNumber).count < 7
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
