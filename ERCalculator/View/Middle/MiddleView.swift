//
//  MiddleView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 03..
//

import SwiftUI

struct MiddleView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: MiddleViewModel
    
    var body: some View {
        Text("MIDDLE")
    }
}

//struct MiddleView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiddleView()
//    }
//}
