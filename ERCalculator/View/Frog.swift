//
//  Frog.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 04..
//

import SwiftUI

struct Frog: View {
    
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        ZStack {
            Text("FROG!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
    }
}

struct Frog_Previews: PreviewProvider {
    static var previews: some View {
        Frog()
    }
}
