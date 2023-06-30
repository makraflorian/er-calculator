//
//  CalculatorButtonType.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 30..
//

import Foundation
import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case delete
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .delete:
            return "←"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .delete:
            return Color(.orange)
        case .digit:
            return .secondary
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .delete:
            return .black
        default:
            return .white
        }
    }
}

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
