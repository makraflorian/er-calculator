//
//  CalculatorsView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 03..
//

import SwiftUI

struct CalculatorsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: CalculatorsViewModel
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.page, label: Text("")) {
                Text("Rune Level").tag(0)
                Text("Summon Range").tag(1)

            }.pickerStyle(.segmented)

            TabView(selection: $viewModel.page,
                    content:  {
                coordinator.constructCalculator().tag(0)
                coordinator.constructSummonRange().tag(1)
                    })
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
//            BubbleSegmentedControl(selectedTab: $viewModel.page, allTabs: Constants.segmentedTabs) {
//                TabView(selection: $viewModel.page) {
//                    coordinator.constructCalculator()
//                        .ignoresSafeArea(.all, edges: .all)
//                        .tag(Constants.segmentedTabs[0])
//
//                    coordinator.constructSummonRange()
//                        .ignoresSafeArea(.all, edges: .all)
//                        .tag(Constants.segmentedTabs[1])
//                }
//        }
//        .ignoresSafeArea(.all, edges: .top)
    }
}

struct CalculatorsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorsView(viewModel: CalculatorsViewModel()).environmentObject(Coordinator())
    }
}
