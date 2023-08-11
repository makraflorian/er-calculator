//
//  ERModalPicker.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 08. 08..
//

import SwiftUI

struct ERModalPicker: View {
    
    @State var presentSheet = false
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    @Binding var selectedItem: PlayerType
    var allItems: [PlayerType]
    
    var title: String
    
    var body: some View {
        HStack {
            Button() {
                presentSheet.toggle()
            } label: {
                HStack {
                    Text(selectedItem.rawValue)
                        .font(.title2)
                        .padding([.leading, .trailing], 5)
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(Color.textColor)
                .frame(maxWidth: .infinity)
                
            }
            .sheet(isPresented: $presentSheet) {
                ZStack {
                    VStack {
                        Text(title)
                            .font(.title2)
                            .foregroundColor(Color.textColor)
                            .padding()
                        ForEach(allItems, id: \.self) { option in
                            ERRadioButton(item: option.rawValue, selected: selectedItem == option)
                                .tag(option)
                                .onTapGesture {
                                    selectedItem = option
                                    /// questionmark and i hate it
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        presentSheet = false
                                    }
                                }
                        }
                    }
                    .padding(30)
                }
                .presentationDetents([.fraction(allItems.count > 2 ? 0.36 : 0.20)])
                .presentationDragIndicator(.visible)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                /// ios 16.4 xd
                //.presentationBackground(.black)
                .background(Color.sheetBackgroundColor)
            }
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .trim(from: 0, to: 0.52)
                    .stroke(Color.iconColor, lineWidth: 1)
                RoundedRectangle(cornerRadius: 50)
                    .trim(from: 0.53 + (0.44 * (labelWidth / width)), to: 1)
                    .stroke(Color.iconColor, lineWidth: 1)
                Text(title)
                    .foregroundColor(Color.textColor)
                    .overlay( GeometryReader { geo in Color.clear.onAppear { labelWidth = geo.size.width }})
                    .padding(2)
                    .font(.callout)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    .offset(x: 0, y: -12)
                
            }
        }
        .overlay( GeometryReader { geo in Color.clear.onAppear { width = geo.size.width }})
        
    }
}

private struct ERRadioButton: View {
    
    let item: String
    let selected: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Text(item)
                .font(.body)
            Spacer()
            Image(systemName: selected ? "circle.dashed.inset.filled" : "circle.dashed")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
        .padding(.bottom, 5)
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .foregroundColor(selected ? Color.textColor : Color.textColor.opacity(0.6))
    }
}


struct ERModalPicker_Previews: PreviewProvider {
    static var previews: some View {
        ERModalPicker(selectedItem: .constant(PlayerType.host), allItems: PlayerType.allCases, title: "Title")
    }
}
