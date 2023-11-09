//
//  BubbleTabView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 05..
//

import Foundation
import SwiftUI

struct BubbleTabView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    @State var xAxis: CGFloat = 0
    @State var isSearching = true
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $coordinator.selectedTab) {
                    Cat()
                        .gesture(isSearching ? DragGesture() : nil)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(Tab.heart)
                    
                    Frog()
//                    SummonRangeView(viewModel: SummonRangeViewModel())
                        .gesture(isSearching ? DragGesture() : nil)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(Tab.moon)
                    
                    coordinator.constructCalculators()
//                        .ignoresSafeArea(.all, edges: .all)
                        .gesture(isSearching ? DragGesture() : nil)
                        .tag(Tab.pawprint)
                }.tabViewStyle(.page(indexDisplayMode: .never))
                //            CUSTOM
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue){image in
                        GeometryReader { reader in
                            Button(action: {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
//                                withAnimation(.spring()){
                                    coordinator.selectedTab = image
                                    xAxis = reader.frame(in: .global).midX
//                                    print(xAxis)
                                }
                            }, label: {
                                Image(systemName: image.rawValue)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 25)
                                    .foregroundColor(coordinator.selectedTab == image ? Color.textColor : Color.iconColor)
                                    .padding(.top, coordinator.selectedTab != image ? 10 : 0)
                                    .padding(coordinator.selectedTab == image ? 15 : 0)
                                    .background(Color.tabBarColor.opacity(coordinator.selectedTab == image ? 1 : 0)).clipShape(Circle())
                                    .matchedGeometryEffect(id: image, in: animation)
                                    .offset(x: coordinator.selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: coordinator.selectedTab == image ? -50 : 0)
                            })
                            .onAppear(perform: {
                                if image == Tab.moon{
                                    xAxis = reader.frame(in: .global).midX
//                                    print(xAxis)
                                }
                            })
                        }
                        .frame(width: 40, height: 30)
                        if image != Tab.pawprint{Spacer(minLength: 0)}
                    }
                }
                .padding(.horizontal, 50)
                .padding(.vertical)
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .background(Color.tabBarColor.clipShape(CurveClipShape(xAxis: xAxis)).cornerRadius(0))
                // .padding(.horizontal)
            }
            .background(Color.clear)
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

extension BubbleTabView {
    
    enum Tab: String, Identifiable, CaseIterable {
        case heart
        case moon
        case pawprint
        
        var id: String {
            self.rawValue
        }
    }
}


struct BubbleTabView_Previews: PreviewProvider {
    static var coordinator = Coordinator()
    static var previews: some View {
        BubbleTabView().environmentObject(coordinator)
    }
}
