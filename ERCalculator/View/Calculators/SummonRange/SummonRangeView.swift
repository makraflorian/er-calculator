//
//  SummonRangeView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 24..
//

import SwiftUI

struct SummonRangeView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: SummonRangeViewModel
    @State var presentSheet = false
    
    var body: some View {
        VStack {
            Text("summonRangeCalculator".localized)
                .font(.title2)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            ERTextField(title: "runeLevel".localized, inputData: $viewModel.inputRuneLevel)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            ERTextField(title: "weaponLevel".localized, inputData: $viewModel.inputWeaponLevel)
                .keyboardType(.numberPad)
            Toggle(isOn: $viewModel.isSomber) {
                Text("isSomber")
            }
            Button("Modal goes brr") {
                viewModel.getRanges()
                presentSheet.toggle()
            }
            .sheet(isPresented: $presentSheet) {
                coordinator.constructSummonRangeDetail(withRanges: viewModel.rangesByType)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .disabled(viewModel.inputRuneLevel.isEmpty && viewModel.inputWeaponLevel.isEmpty)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainColor)
        .onTapGesture {
            self.endTextEditing()
        }
    }
}



struct SummonRangeView_Previews: PreviewProvider {
    static var previews: some View {
        SummonRangeView(viewModel: SummonRangeViewModel()).environmentObject(Coordinator())
    }
}
