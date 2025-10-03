//
//  ERCalculatorApp.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 29..
//

import SwiftUI
//import SwiftData

@main
struct ERCalculatorApp: App {
//    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    @StateObject private var coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            BubbleTabView().environmentObject(coordinator).ignoresSafeArea(.keyboard)
        }
//        .modelContainer(ItemsContainer.create(shouldCreateDefaults: &isFirstTimeLaunch))
    }
}
