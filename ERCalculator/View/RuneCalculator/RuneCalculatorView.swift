//
//  RuneCalculatorView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 30..
//

import SwiftUI

struct RuneCalculatorView: View {
    
    var body: some View {
        VStack {
            Text("segmented control | Invasion | Summon range |")
            Text("You are a: ===PICKER===")
            Text("The player was: ===PICKER===")
            Text("The player's rune level was: 120")
            Spacer()
            NumberField()
            ButtonPad()
        }
        .padding(12.0)
        .background(.gray)
    }
    
    private struct NumberField: View {
        var body: some View {
            Text("TODO")
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 88, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
    }
    
    private struct ButtonPad: View {
        
        var buttonTypes: [[ButtonType]] {
            [[.digit(.seven), .digit(.eight), .digit(.nine)],
             [.digit(.four), .digit(.five), .digit(.six)],
             [.digit(.one), .digit(.two), .digit(.three)],
             [.digit(.zero), .delete]]
        }
        
        var body: some View {
            VStack(spacing: 12.0) {
                ForEach(buttonTypes, id: \.self) { row in
                    HStack(spacing: 12.0) {
                        ForEach(row, id: \.self) { buttonType in
                            CalculatorButton(buttonType: buttonType)
                        }
                    }
                }
            }
        }
    }
}

struct RuneCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        RuneCalculatorView()
    }
}
