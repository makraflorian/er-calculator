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
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $coordinator.selectedTab) {
                    Cat()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(Tab.heart)
                    
                    Frog()
//                    SummonRangeView(viewModel: SummonRangeViewModel())
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(Tab.moon)
                    
                    coordinator.constructCalculators()
                    // .ignoresSafeArea(.all, edges: .all)
                        .tag(Tab.pawprint)
                }
                //            CUSTOM
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue){image in
                        GeometryReader { reader in
                            Button(action: {
                                withAnimation(.spring()){
                                    coordinator.selectedTab = image
                                    xAxis = reader.frame(in: .global).midX
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
                .background(Color.tabBarColor.clipShape(Curve(xAxis: xAxis)).cornerRadius(0))
                // .padding(.horizontal)
            }
            .ignoresSafeArea(.all, edges: .bottom)
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

// MARK: - CURVE
private struct Curve: Shape {
    
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct BubbleTabView_Previews: PreviewProvider {
    static var coordinator = Coordinator()
    static var previews: some View {
        BubbleTabView().environmentObject(coordinator)
    }
}
