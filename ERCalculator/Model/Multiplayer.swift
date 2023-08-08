//
//  Multiplayer.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 13..
//

import Foundation

enum PlayerType: String, Identifiable, CaseIterable {
    case host = "Host"
    case invader = "Invader"
    case furledFinger = "Furled Finger"
    case hunter = "Hunter"
    case duelist = "Duelist"
    
    var id: String {
        self.rawValue
    }
    
    static let friendly: [PlayerType] = [.host, .furledFinger, .hunter]
    static let enemy: [PlayerType] = [.invader, .duelist]
}

struct MultiplayerRanges: Identifiable {
    
    var id: String { name }
    let name: String
    let ranges: [LevelRange]
}

struct LevelRange: Identifiable {
    
    var id: String { name }
    let name: String
    let minLevel: Int
    let maxLevel: Int
}
