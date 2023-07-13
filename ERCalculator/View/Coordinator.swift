//
//  Coordinator.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 03..
//

import Foundation
import Combine
import SwiftUI

//enum Page: String, Identifiable {
//    case boss, build, calculator, frog, cat
//
//    var id: String {
//        self.rawValue
//    }
//}

class Coordinator: ObservableObject {
    //    @Published var path = NavigationPath()
    @Published var selectedTab = BubbleTabView.Tab.moon
    // For later
    //    func push(_ page: Page) {
    //        path.append(page)
    //    }
    //
    //    func pop() {
    //        path.removeLast()
    //    }
    //
    //    func popToRoot() {
    //        path.removeLast(path.count)
    //    }
    //
    //    @ViewBuilder
    //    func build(page: Page) -> some View {
    //        switch page {
    //        case .boss:
    //            constructBoss()
    //        case .build:
    //            constructBuild()
    //        case .calculator:
    //            constructCalculator()
    //        case .frog:
    //            Frog()
    //        case .cat:
    //            Cat()
    //        }
    //    }
    
    // MARK: - CONSTRUCT VIEWS

    func constructTabView() -> some View {
        let tabView = BubbleTabView().environmentObject(self)
        return tabView
    }
    
    func constructBoss() -> some View {
        let viewModel = LeftViewModel()
        let leftView = LeftView(viewModel: viewModel).environmentObject(self)
        return leftView
    }
    
    func constructBuild() -> some View {
        let viewModel = MiddleViewModel()
        let middleView = MiddleView(viewModel: viewModel).environmentObject(self)
        return middleView
    }
    
    func constructCalculator() -> some View {
        let viewModel = RuneCalculatorViewModel()
        let calcView = RuneCalculatorView(viewModel: viewModel).environmentObject(self)
        return calcView
    }
}
