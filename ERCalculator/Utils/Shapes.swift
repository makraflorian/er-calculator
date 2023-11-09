//
//  Shapes.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 11. 06..
//

import Foundation
import SwiftUI

struct CurveClipShape: Shape {
    
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            
            let center = xAxis
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct RectangleClipShape: Shape {
    
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            
            let center = xAxis
            let topRadius = CGFloat(15)
            let bottomRadius = CGFloat(15)
            
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            path.addArc(tangent1End: CGPoint(x: center-60, y: rect.height), tangent2End: CGPoint(x: center-60, y: rect.height-40), radius: bottomRadius)
            path.addArc(tangent1End: CGPoint(x: center-60, y: rect.height-40), tangent2End: CGPoint(x: center+60, y: rect.height-40), radius: topRadius)
            path.addArc(tangent1End: CGPoint(x: center+60, y: rect.height-40), tangent2End: CGPoint(x: center+60, y: rect.height+40), radius: topRadius)
            path.addArc(tangent1End: CGPoint(x: center+60, y: rect.height), tangent2End: CGPoint(x: center+160, y: rect.height), radius: bottomRadius)
            
        }
    }
}
