//
//  SummonRangeViewModel.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 24..
//

import Foundation

class SummonRangeViewModel: ObservableObject {
    
    @Published var inputRuneLevel: String = ""
    @Published var inputWeaponLevel: String = ""
    @Published var isSomber = false
    
    @Published var rangesByType: [MultiplayerRanges] = []
    
    private var runeLevel: Double? {
        Double(inputRuneLevel)
    }
    private var weaponLevel: Int? {
        Int(inputWeaponLevel)
    }
    
    func getRanges() {
        
        rangesByType = []
        
        if !inputRuneLevel.isEmpty {
            let summonMin = getLevelMinMax(coefficents: SummonRangeCoefficents.summonMin)
            let summonMax = getLevelMinMax(coefficents: SummonRangeCoefficents.summonMax)
            let canSummon = LevelRange(name: "canSummon", minLevel: summonMin.0, maxLevel: summonMax.0)
            let canBeSummonedBy = LevelRange(name: "canBeSummonedBy", minLevel: summonMin.1, maxLevel: summonMax.1)

            let invadeMin = getLevelMinMax(coefficents: SummonRangeCoefficents.invadeMin)
            let invadeMax = getLevelMinMax(coefficents: SummonRangeCoefficents.invadeMax)
            let canInvade = LevelRange(name: "canInvade", minLevel: invadeMin.0, maxLevel: invadeMax.0)
            let canBeInvadedBy = LevelRange(name: "canBeInvadedBy", minLevel: invadeMin.1, maxLevel: invadeMax.1)
            
            let coopRanges = MultiplayerRanges(name: "coopRanges", ranges: [canSummon, canBeSummonedBy])
            let pvpRanges = MultiplayerRanges(name: "pvpRanges", ranges: [canInvade, canBeInvadedBy])
            
            rangesByType.append(contentsOf:[coopRanges, pvpRanges])
        }
        
        if !inputWeaponLevel.isEmpty {
            let weaponLevelData = getWeaponMinMax()
            let regularWeapon = LevelRange(name: "regularWeapon", minLevel: weaponLevelData[0], maxLevel: weaponLevelData[1])
            let somberWeapon = LevelRange(name: "somberWeapon", minLevel: weaponLevelData[2], maxLevel: weaponLevelData[3])
            
            let weaponRanges = MultiplayerRanges(name: "weaponRanges", ranges: [regularWeapon, somberWeapon])
            
            rangesByType.append(weaponRanges)
        }

    }
    
    func getLevelMinMax(coefficents: SummonRangeCoefficents) -> (Int, Int) {
        let result = Int(floor((runeLevel ?? 0.0) * coefficents.a + coefficents.b))
        let resultReverse = Int(ceil(((runeLevel ?? 0.0) + coefficents.reverseB) / coefficents.reverseA))
        return (result, resultReverse)
    }
    
    func getWeaponMinMax() -> [Int] {
        if !isSomber {
            let weaponTableRow = Constants.weaponRegularRangeTable.first(where: { $0.key == weaponLevel ?? 0 })
            return weaponTableRow?.value ?? []
        } else {
            let weaponTableRow = Constants.weaponSomberRangeTable.first(where: { $0.key == weaponLevel ?? 0 })
            return weaponTableRow?.value ?? []
        }
    }
    
}
