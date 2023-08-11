//
//  CalculatorHelpers.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 07..
//

import Foundation

func cubicSolve(a: Double, b: Double, c: Double, d: Double, threshold: Double = 0.0001) -> Double {
    
    var root: Double = 0.0
    
    let a_1 = b/a
    let a_2 = c/a
    let a_3 = d/a
    
    let q = (3*a_2 - pow(a_1, 2))/9
    let r = (9*a_1*a_2 - 27*a_3 - 2*pow(a_1, 3))/54
    
    let s = cbrt(r + sqrt(pow(q, 3)+pow(r, 2)))
    let t = cbrt(r - sqrt(pow(q, 3)+pow(r, 2)))
    
    var d = pow(q, 3) + pow(r, 2)
    
    /// Check if d is within the zero threshold
    if -threshold < d && d < threshold { d = 0 }
    
    if d > 0 {
        root = s + t - (1/3)*a_1
        
    } else if d <= 0 {
        let theta = acos(r/sqrt(-pow(q, 3)))
        root = (2*sqrt(-q)*cos((1/3)*theta) - (1/3)*a_1)
    }
    
    return root
}

func runesForLevel(guess: Double) -> Double {
    
    let guess_rounded = floor(guess)
    
    let coefficents = guess_rounded >= 13.0 ? Coefficents.high : Coefficents.low
    
    let helper_cubic = (coefficents.a * pow(guess_rounded, 3))
    let helper_quadratic = (coefficents.b * pow(guess_rounded, 2))
    let helper_basic = (coefficents.c * guess_rounded)
    
    let runes = floor(helper_cubic + helper_quadratic + helper_basic + coefficents.d)
    
    return runes
}

func getLevel(number: Decimal, multiplier: Double) -> Double {
    
    /// Get the last level up rune amount
    let runes_got = NSDecimalNumber(decimal: number).doubleValue
    let runes = runes_got / multiplier
    print("RUNES = \(runes)")
    
    /// Decide if low level or high level coefficents
    let coefficents = runes >= 1038 ? Coefficents.high : Coefficents.low
    
    /// Get the rough level value based on the more precise DS3 formula
    let guess = cubicSolve(a: coefficents.a, b: coefficents == .high ? coefficents.b - 0.01 : coefficents.b, c: coefficents.c, d: coefficents.d - runes)
    print("GUESS = \(guess)")
//        let res1 = cubicSolve(a: 0.02, b: 3.12, c: 111.78, d: -786.32 - runes) // ER formula
//        print("RES1 = \(res1)")
    
    /// Calculate the required runes for the guessed level and corrects the result based on this checks
    let helper_current = floor(runesForLevel(guess: guess) * multiplier)
    let helper_above = floor(runesForLevel(guess: guess + 1.0) * multiplier)
    print("CURRENT = \(helper_current)")
    if helper_current > floor(runes_got) {
        return guess - 1.0
    } else if helper_above <= floor(runes_got){
        return guess + 1.0
    } else {
        return guess
    }
}

func getPercent(player: PlayerType, enemy: PlayerType) -> Double {
    
    switch (player, enemy) {
    case (.invader, let other) where [.host, .furledFinger, .hunter].contains(other):
        return 0.04
    case (.host, .invader):
        return 0.15
    case (.host, .duelist):
        return 0.02
    case (_, .duelist):
        return 0.01
    case (let other, .invader) where [.furledFinger, .hunter].contains(other):
        return 0.05
    case (.duelist, _):
        return 0.01
    case (.invader, .invader):
        return 0.01
    case (_, _):
        return 0.0
    }

}
