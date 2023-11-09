//
//  TestView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 09. 26..
//

import SwiftUI

struct TestView: View {

    @State var selectedTab = Constants.segmentedTabs[0]
    
    var body: some View {
        BubbleSegmentedControl(selectedTab: $selectedTab, allTabs: Constants.segmentedTabs) {
            TabView(selection: $selectedTab) {
                Cat()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Constants.segmentedTabs[0])

                Frog()
//                    SummonRangeView(viewModel: SummonRangeViewModel())
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(Constants.segmentedTabs[1])
//                Cat()
//                    .ignoresSafeArea(.all, edges: .all)

            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
