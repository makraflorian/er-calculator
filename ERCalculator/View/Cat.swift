//
//  Cat.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 04..
//

import SwiftUI

struct Cat: View {
    var color = Color.orange
    var body: some View {
        ZStack {
            Text("Cat!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
    }
}

struct Cat_Previews: PreviewProvider {
    static var previews: some View {
        Cat()
    }
}
