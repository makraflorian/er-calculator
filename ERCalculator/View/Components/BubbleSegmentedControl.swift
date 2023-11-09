//
//  BubbleSegmentedControl.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 09. 11..
//

import Foundation
import SwiftUI


struct TabSelectionValueType: Hashable {
    var tabName: String
    var tabImage: String
}

struct BubbleSegmentedControl<Content>: View where Content: View {
//    @EnvironmentObject var coordinator: Coordinator
//public struct TabView<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
    
//    let content: Content
    
    @Binding var selectedTab: TabSelectionValueType
    var allTabs: [TabSelectionValueType]

    @ViewBuilder let content: () -> Content
    @State var xAxis2: CGFloat = 0
    @Namespace var animation2
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                content()
                //            CUSTOM
                HStack(spacing: 0) {
                    ForEach(allTabs, id: \.self){image in
                        GeometryReader { reader2 in
                            Button(action: {
                                withAnimation(.spring()){
                                    selectedTab = image
                                    xAxis2 = reader2.frame(in: .global).midX
                                    print(xAxis2)
//                                    print(reader2.frame(in: .global).minY)
                                }
                            }, label: {
                                Text("\(image.tabName)")
//                                    .resizable()
//                                    .renderingMode(.template)
//                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 25)
                                    .foregroundColor(selectedTab == image ? Color.textColor : Color.iconColor)
                                    .padding(.top, selectedTab != image ? 10 : 0)
                                    .padding(selectedTab == image ? 15 : 0)
//                                    .background(Color.tabBarColor.opacity(selectedTab == image ? 1 : 0)).clipShape(Circle())
                                    .matchedGeometryEffect(id: image, in: animation2)
                                    .offset(x: selectedTab == image ? (reader2.frame(in: .global).minX - reader2.frame(in: .global).midX) : 0, y: -5)
                            })
                            .onAppear(perform: {
                                if image == allTabs.first {
                                    xAxis2 = reader2.frame(in: .global).midX
                                    print(reader2.frame(in: .global).minY)
                                }
                            })
                        }
                        .frame(width: 40, height: 30)
                        if image != allTabs.last{Spacer(minLength: 0)}
                    }
                }
                .padding(.horizontal, 50)
//                .padding(.vertical)
                .padding(.top, geometry.safeAreaInsets.top)
                .background(Color.tabBarColor.clipShape(RectangleClipShape(xAxis: xAxis2)).cornerRadius(0))
//                 .padding(.horizontal)
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}
