//
//  ERCalculatorApp.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 29..
//

import SwiftUI

@main
struct ERCalculatorApp: App {
    @StateObject private var coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            BubbleTabView().environmentObject(coordinator).ignoresSafeArea(.keyboard)
        }
    }
}
