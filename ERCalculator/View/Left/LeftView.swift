//
//  LeftView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 03..
//

import SwiftUI

struct LeftView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LeftViewModel
    
    var body: some View {
        Text("LEFT")
    }
}

//struct LeftView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeftView()
//    }
//}
