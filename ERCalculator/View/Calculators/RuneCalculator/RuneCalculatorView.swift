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
            Text("runeLevelCalculator".localized)
//                .padding(.top, 90)
                .font(.title2)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            ERModalPicker(selectedItem: $viewModel.selectedPlayer, allItems: PlayerType.allCases, title: "You are a:")
                .onChange(of: viewModel.selectedPlayer) { _ in
                    viewModel.changePlayer()
                    viewModel.calc()
                }.padding(.bottom, 10)
            ERModalPicker(selectedItem: $viewModel.selectedEnemy, allItems: viewModel.selectionEnemyArray, title: "The other player was a: ")
                .onChange(of: viewModel.selectedEnemy) { _ in    viewModel.calc()  }
            HStack {
                Text("The player's Rune Level was:")
                    .foregroundColor(Color.textColor)
                    .font(.title2)
                Text(viewModel.resultText)
                    .foregroundColor(Color.iconColor)
                    .font(.title)
            }
            Text("Level \(viewModel.resultLevel) drops: \(viewModel.currentText), and \(viewModel.resultLevel+1) drops: \(viewModel.aboveText) runes")
                .foregroundColor(Color.textColor.opacity(0.7))
                .font(.callout)
            Spacer()
            Divider()
                .overlay(Color.iconColor)
            NumberField(viewModel: viewModel)
            ButtonPad(viewModel: viewModel).padding(.bottom, 90)
        }
        .padding(12.0)
        .background(LinearGradient(gradient: Gradient(colors: [.mainGradientDarker, .mainGradientLighter]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    // MARK: - COMPONENTS
    
    private struct NumberField: View {
        
        @StateObject var viewModel: RuneCalculatorViewModel
        
        var body: some View {
            Text(viewModel.displayText)
                .padding(6)
                .foregroundColor(Color.iconColor)
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
                                viewModel.performAction(for: buttonType)
                                let hapticImpact = UIImpactFeedbackGenerator(style: .soft)
                                hapticImpact.impactOccurred()
                            },
                                             buttonType: buttonType)
//                            .simultaneousGesture(DragGesture())
                            .simultaneousGesture(LongPressGesture()
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
