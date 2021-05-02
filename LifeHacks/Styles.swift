//
//  Styles.swift
//  LifeHacks
//
//  Created by Ethan Smith on 1/05/21.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static var blue: Self { verticalGradient(with: [.lightBlue, .blue]) }
    static var orange: Self { verticalGradient(with: [.lightOrange, .orange]) }
    static var green: Self { verticalGradient(with: [.lightGreen, .green]) }
    static var teal: Self { verticalGradient(with: [.lightTeal, .teal]) }
    
    private static func verticalGradient(with colors: [Color]) -> Self {
        let gradient = Gradient(colors: colors)
        return LinearGradient(gradient: gradient, startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 1.0))
    }
}

//extension LinearGradient {
//    static var blue: Self {
//        let gradient = Gradient(colors: [.lightBlue, .blue])
//        return LinearGradient(gradient: gradient, startPoint: .init(x: 0, y: 0), endPoint: .init(x: 0, y: 1))
//    }
//}

struct Style: ViewModifier {
    let gradient: LinearGradient
    var filled = true
    
    func body(content: Content) -> some View {
        Group {
            if filled {
                content
                    .background(gradient)
                    .cornerRadius(6.0)
                    .foregroundColor(.white)
            } else {
                content
                    .background(RoundedRectangle(cornerRadius: 6.0)
                                    .strokeBorder(gradient, lineWidth: 2.0))
            }
        }
    }
}

struct Styles_Previews: PreviewProvider {
    static var stack: some View {
        VStack(spacing: 16) {
            Text("Blue style")
                .padding()
                .blueStyle()
            Text("Orange style")
                .padding()
                .orangeStyle()
            Text("Orange empty style")
                .padding()
                .orangeStyle(filled: false)
            Text("Teal style")
                .padding()
                .tealStyle()
            Text("Green style")
                .padding()
                .greenStyle()
            Text("Green empty style")
                .padding()
                .greenStyle(filled: false)
        }
        .previewLayout(.sizeThatFits)
    }
    
    static var previews: some View {
        Group {
            stack
                .padding()
                .previewDisplayName("Light mode")
            stack
                .padding()
                .background(Color(UIColor.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
        }
    }
    
}

extension View {
    func blueStyle() -> some View {
        modifier(Style(gradient: .blue))
    }
    
    func tealStyle() -> some View {
        modifier(Style(gradient: .teal))
    }
    
    func orangeStyle(filled: Bool = true) -> some View {
        modifier(Style(gradient: .orange, filled: filled))
    }
    
    func greenStyle(filled: Bool = true) -> some View {
        modifier(Style(gradient: .green, filled: filled))
    }
}

//MARK: - Colors

extension UIColor {
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue, saturation, brightness, alpha)
    }
    
    func colorWithOffsets(hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0) -> UIColor {
        UIColor(
            hue: hsba.hue + hue,
            saturation: hsba.saturation + saturation,
            brightness: hsba.brightness + brightness,
            alpha: hsba.alpha + alpha
        )
    }
}

extension Color {
    static var lightBlue: Color { Color(UIColor.systemBlue.colorWithOffsets(saturation: -0.5)) }
    static var lightOrange: Color { Color(UIColor.systemOrange.colorWithOffsets(saturation: -0.5)) }
    static var lightGreen: Color { Color(UIColor.systemGreen.colorWithOffsets(saturation: -0.15, brightness: 0.2)) }
    static var teal: Color { Color(UIColor.systemTeal) }
    static var lightTeal: Color { Color(UIColor.systemTeal.colorWithOffsets(saturation: -0.3)) }
}
