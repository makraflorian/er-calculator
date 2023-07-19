//
//  Constants.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 17..
//

import Foundation

enum Coefficents {
    case low
    case high
    
    var a: Double {
        switch self {
        case .low:
            return 0.0068
        case .high:
            return 0.02
        }
    }
    var b: Double {
        switch self {
        case .low:
            return -0.06
        case .high:
            return 3.06
        }
    }
    var c: Double {
        switch self {
        case .low:
            return 17.1
        case .high:
            return 105.6
        }
    }
    var d: Double {
        switch self {
        case .low:
            return 639.0
        case .high:
            return -895.0
        }
    }
}

//struct Constants {
//
//
//}
