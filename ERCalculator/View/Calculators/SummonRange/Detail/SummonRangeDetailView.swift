//
//  SummonRangeDetailView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 25..
//

import SwiftUI

struct SummonRangeDetailView: View {
    
    @StateObject var viewModel: SummonRangeDetailViewModel
    
    var body: some View {
        TabView {
            ForEach(viewModel.ranges) { range in
                RangesView(title: range.name.localized, levelRanges: range.ranges)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct RangesView: View {
    
    let title: String
    let levelRanges: [LevelRange]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(Color.textColor)
            ForEach(levelRanges) { range in
                RangeCardView(range: range)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct RangeCardView: View {
    
    let range: LevelRange
    
    var body: some View {
        HStack(alignment: .center) {
            Image(range.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
            //                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color.iconColor, lineWidth: 2)
                    
                }
                .padding(20)
                .foregroundColor(.teal)
            VStack(alignment: .leading) {
                Text(range.name.localized)
                    .foregroundColor(Color.textColor)
                HStack {
                    Text("\(range.minLevel)")
                        .foregroundColor(Color.textColor)
                    Text("\(range.maxLevel)")
                        .foregroundColor(Color.textColor)
                }
            }
            .padding(.trailing, 20)
            Spacer()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(Color.iconColor, lineWidth: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
//        .background(Color.gray)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
        .padding(10)
    }
}

struct SummonRangeDetailView_Previews: PreviewProvider {
    
    static let viewmodel = SummonRangeDetailViewModel(ranges: [MultiplayerRanges(name: "coopRanges", ranges: [LevelRange(name: "Can Summon", minLevel: 10, maxLevel: 10)])])
    static var previews: some View {
        SummonRangeDetailView(viewModel: viewmodel)
    }
}
