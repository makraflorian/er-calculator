//
//  ColorExtension.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 08. 08..
//

import SwiftUI

extension ShapeStyle where Self == Color {

    init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B)
    }

    static var erBackground: Color { Color(UIColor.systemGray6) }
    static var mainColor: Color { Color("MainColor") }
    static var mainGradientDarker: Color { Color("MainGradientDarker") }
    static var mainGradientLighter: Color { Color("MainGradientLighter") }
    static var sheetBackgroundColor: Color { Color("SheetBackgroundColor") }
    static var iconColor: Color { Color("IconColor") }
    static var textColor: Color { Color("TextColor") }
    static var tabBarColor: Color { Color("TabBarColor") }
    

}
