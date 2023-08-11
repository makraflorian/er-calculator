//
//  SwiftUIView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 30..
//

import SwiftUI

struct CalculatorButton: View {
    
    let action: () -> Void
    let buttonType: ButtonType
    
    var body: some View {
        Button(buttonType.description, action: action)
            .buttonStyle(CalculatorButtonStyle(
                size: 70,
                backgroundColor: buttonType.backgroundColor,
                foregroundColor: buttonType.foregroundColor,
                isWide: buttonType == .digit(.zero)))
    }
}

// MARK: - STYLE

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
                Capsule()
                    .stroke(Color.iconColor.opacity(0.7), lineWidth: 3)
                if configuration.isPressed {
                    Color.textColor.opacity(0.2)
                }
            }
            .clipShape(Capsule())
    }
}


struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(action: {}, buttonType: .digit(.five))
        CalculatorButton(action: {}, buttonType: .delete)
    }
}
