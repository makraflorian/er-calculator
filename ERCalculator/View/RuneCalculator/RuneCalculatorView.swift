//
//  RuneCalculatorView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 06. 30..
//

import SwiftUI

struct RuneCalculatorView: View {
    //    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: RuneCalculatorViewModel
    @State private var page = 0
    
    var body: some View {
        VStack {
            Picker("Calculators", selection: $page) {
                Text("Invasion").tag(0)
                Text("Summon range").tag(1)
            }
            .pickerStyle(.segmented)
            //            Text("segmented control | Invasion | Summon range |")
            Text("You are a: ===PICKER===")
            Picker("Calculators", selection: $page) {
                Text("Invasion").tag(0)
                Text("Summon range").tag(1)
            }
            .pickerStyle(.inline)
            Text("The player was: ===PICKER===")
            Picker("Calculators", selection: $page) {
                Text("Invasion").tag(0)
                Text("Summon range").tag(1)
            }
            .pickerStyle(.wheel)
            Text("The player's rune level was: \(viewModel.resultText)")
            Text("For current level: \(viewModel.currentText) above: \(viewModel.aboveText)")
            Spacer()
            NumberField(viewModel: viewModel)
            ButtonPad(viewModel: viewModel).padding(.bottom, 100)
        }
        .padding(12.0)
        .background(.gray)
    }
    
    // MARK: - COMPONENTS
    
    private struct NumberField: View {
        
        @StateObject var viewModel: RuneCalculatorViewModel
        
        var body: some View {
            Text(viewModel.displayText)
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 88, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
    }
    
    private struct ButtonPad: View {
        
        @StateObject var viewModel: RuneCalculatorViewModel
        
        var body: some View {
            VStack(spacing: 12.0) {
                ForEach(viewModel.buttonTypes, id: \.self) { row in
                    HStack(spacing: 12.0) {
                        ForEach(row, id: \.self) { buttonType in
                            CalculatorButton(action: {
                                viewModel.performAction(for: buttonType)},
                                             buttonType: buttonType)
                        }
                    }
                }
            }
        }
    }
}

struct RuneCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        RuneCalculatorView(viewModel: RuneCalculatorViewModel())
    }
}
