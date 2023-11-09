//
//  ViewExtension.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 08. 07..
//

import Foundation
import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        self.modifier(HapticFeedback(style: style))
    }
}

struct HapticFeedback: ViewModifier {
    private let generator: UIImpactFeedbackGenerator
    
    init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        generator = UIImpactFeedbackGenerator(style: style)
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture(perform: generator.impactOccurred)
    }
}
