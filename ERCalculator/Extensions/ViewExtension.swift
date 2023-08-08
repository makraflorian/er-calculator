//
//  ViewExtension.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 08. 07..
//

import Foundation
import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
