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
            Text("Summon Range Calculator")
            TextField("Rune Level", text: $viewModel.inputRuneLevel)
                .keyboardType(.numberPad)
            TextField("Weapon Level", text: $viewModel.inputWeaponLevel)
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
        }
        .background(Color.gray)
        .onTapGesture {
            self.endTextEditing()
        }
    }
}



struct SummonRangeView_Previews: PreviewProvider {
    static var previews: some View {
        SummonRangeView(viewModel: SummonRangeViewModel())
    }
}
