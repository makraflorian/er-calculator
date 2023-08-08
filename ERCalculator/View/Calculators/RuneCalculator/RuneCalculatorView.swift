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
    
    var body: some View {
        VStack {
            Text("You are a: ===PICKER===")
            Picker("Calculators", selection: $viewModel.selectedPlayer) {
                ForEach(PlayerType.allCases, id: \.rawValue) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .onChange(of: viewModel.selectedPlayer) { _ in
                viewModel.changePlayer()
                viewModel.calc()
            }
            .pickerStyle(.menu)
            Text("The player was: ===PICKER===")
            Picker("Calculators", selection: $viewModel.selectedEnemy) {
                ForEach(viewModel.selectionEnemyArray, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .onChange(of: viewModel.selectedEnemy) { _ in    viewModel.calc()  }
            .pickerStyle(.menu)
            Text("The player's rune level was: \(viewModel.resultText)")
            Text("For current level: \(viewModel.currentText) above: \(viewModel.aboveText)")
            Spacer()
            NumberField(viewModel: viewModel)
            ButtonPad(viewModel: viewModel).padding(.bottom, 90)
        }
        .padding(12.0)
        .background(.gray)
    }
    
    // MARK: - COMPONENTS
    
    private struct NumberField: View {
        
        @StateObject var viewModel: RuneCalculatorViewModel
        
        var body: some View {
            Text(viewModel.displayText)
                .padding(6)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 80, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
    }
    
    private struct ButtonPad: View {
        
        @StateObject var viewModel: RuneCalculatorViewModel
        
        var body: some View {
            VStack(spacing: 10.0) {
                ForEach(viewModel.buttonTypes, id: \.self) { row in
                    HStack(spacing: 10.0) {
                        ForEach(row, id: \.self) { buttonType in
                            CalculatorButton(action: {
                                viewModel.performAction(for: buttonType)},
                                             buttonType: buttonType)    .simultaneousGesture(LongPressGesture()
                                                .onEnded { _ in
                                                    viewModel.clearAll(buttonType: buttonType)
                                                }
                                            )
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
