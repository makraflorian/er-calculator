//
//  SummonRangeDetailViewModel.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 25..
//

import Foundation

class SummonRangeDetailViewModel: ObservableObject {
    
    @Published var ranges: [MultiplayerRanges]

    init(ranges: [MultiplayerRanges]) {
        self.ranges = ranges
    }
}
