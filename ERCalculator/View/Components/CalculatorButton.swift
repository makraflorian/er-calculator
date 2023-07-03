//
//  SwiftUIView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 30..
//

import SwiftUI

struct CalculatorButton: View {
    let buttonType: ButtonType
    
    var body: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(
                size: 80,
                backgroundColor: buttonType.backgroundColor,
                foregroundColor: buttonType.foregroundColor,
                isWide: buttonType == .digit(.zero)))
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    var isWide: Bool = false
    
    func makeBody(configuration: Configuration) -> some View { configuration.label
                .font(.system(size: 32, weight: .medium))
                .frame(width: size, height: size)
                .frame(maxWidth: isWide ? (size*2)+12.0 : size, alignment: .leading)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .overlay {
                    if configuration.isPressed {
                        Color(white: 1.0, opacity: 0.2)
                    }
                }
                .clipShape(Capsule())
    }
}


struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(buttonType: .digit(.five))
        CalculatorButton(buttonType: .delete)
    }
}
