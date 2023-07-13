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
    
    let helper_cubic = (0.02 * pow(guess_rounded, 3))
    let helper_quadratic = (3.06 * pow(guess_rounded, 2))
    let helper_basic = (105.6 * guess_rounded)
    
    let runes = floor(helper_cubic + helper_quadratic + helper_basic - 895)
    
    return runes
}
