//
//  ERTextField.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 08. 07..
//

import SwiftUI

struct ERTextField: View {
    
    @FocusState private var fieldIsFocused: Bool
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    var title: String
    @Binding var inputData: String
    var placeholder: String?
    
    var body: some View {
        TextField("", text: $inputData)
            .focused($fieldIsFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 12.0, trailing: 16.0))
            .padding(5)
//            .frame(maxWidth: .infinity)
//            .contentShape(RoundedRectangle(cornerRadius: 50))
        ///check Javier's answer https://stackoverflow.com/questions/71408057/textfield-stroke-border-text-with-swiftui
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .trim(from: 0, to: 0.52)
                        .stroke(Color.iconColor.opacity(fieldIsFocused ? 1 : 0.5), lineWidth: fieldIsFocused ? 2 : 1)
                    RoundedRectangle(cornerRadius: 50)
                        .trim(from: 0.535 + (0.44 * (labelWidth / width)), to: 1)
                        .stroke(Color.iconColor.opacity(fieldIsFocused ? 1 : 0.5), lineWidth: fieldIsFocused ? 2 : 1)
                    Text(title)
                        .foregroundColor(Color.textColor)
                        .overlay( GeometryReader { geo in Color.clear.onAppear { labelWidth = geo.size.width }})
                        .padding(2)
                        .font(fieldIsFocused ? .body : .callout)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .offset(x: 0, y: -12)
                }
            }
            .overlay( GeometryReader { geo in Color.clear.onAppear { width = geo.size.width }})
    }
}

struct ERTextField_Previews: PreviewProvider {
    static var previews: some View {
        ERTextField(title: "textfield", inputData: .constant("value"))
    }
}
