//
//  Constants.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 17..
//

import Foundation

enum Tab2: String, Identifiable, CaseIterable {
    case invasion
    case runeLevel
    
    var id: String {
        self.rawValue
    }
}

struct Coefficents: Equatable {
    
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    static let low = Coefficents(a: 0.0068, b: -0.06, c: 17.1, d: 639.0)
    static let high = Coefficents(a: 0.02, b: 3.06, c: 105.6, d: -895.0)

}

struct SummonRangeCoefficents: Equatable {
    
    let a: Double
    let b: Double
    let reverseA: Double
    let reverseB: Double

    static let summonMin = SummonRangeCoefficents(a: 0.9, b: -10.0, reverseA: 1.1, reverseB: -10.0)
    static let summonMax = SummonRangeCoefficents(a: 1.1, b: 10.0, reverseA: 0.9, reverseB: 10.0)
    static let invadeMin = SummonRangeCoefficents(a: 0.9, b: 0.0, reverseA: 1.1, reverseB: -20.0)
    static let invadeMax = SummonRangeCoefficents(a: 1.1, b: 20.0, reverseA: 0.9, reverseB: 0.0)

}

struct Constants {
    
    static let maxRuneLevel: Int = 713
    static let lowRuneLevelBorder: Int = 13
    static let lowLevelBorderRunes: Int = 1038
    
    static let segmentedTabs: [TabSelectionValueType] = [TabSelectionValueType(tabName: "one", tabImage: "hearth"), TabSelectionValueType(tabName: "two", tabImage: "pawprint")]
    
    /// key: [minRegular, maxRegular, minUnique, maxunique]
    static let weaponRegularRangeTable = [
        0:[0,3,0,1],
        1:[0,4,0,1],
        2:[0,5,0,2],
        3:[0,6,0,2],
        4:[1,7,1,3],
        5:[2,8,1,3],
        6:[3,10,2,4],
        7:[4,11,2,4],
        8:[5,12,2,5],
        9:[6,13,3,5],
        10:[6,14,3,5],
        11:[7,15,3,6],
        12:[8,17,4,7],
        13:[9,18,4,7],
        14:[10,19,4,7],
        15:[11,20,5,8],
        16:[12,21,5,8],
        17:[12,22,5,9],
        18:[13,24,6,9],
        19:[14,25,6,10],
        20:[15,25,6,10],
        21:[16,25,7,10],
        22:[17,25,7,10],
        23:[18,25,8,10],
        24:[18,25,8,10],
        25:[19,25,8,10]
    ]
    
    static let weaponSomberRangeTable = [
        0:[0,3,0,1],
        1:[0,5,0,2],
        2:[2,8,1,3],
        3:[4,11,2,4],
        4:[6,14,3,5],
        5:[8,17,4,7],
        6:[11,20,5,8],
        7:[12,22,5,9],
        8:[15,25,6,10],
        9:[17,25,7,10],
        10:[19,25,8,10]
    ]
}
