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

struct Style: ViewModifier {
    let role: Role
    var filled = true
    var rounded = true
    
    @Environment(\.theme) private var theme: Theme
    
    var gradient: LinearGradient {
        role == .primary
            ? theme.primaryGradient
            : theme.secondaryGradient
    }
    
    var cornerRadius: CGFloat {
        rounded ? 6.0 : 0.0
    }
    
    func body(content: Content) -> some View {
        Group {
            if filled {
                content
                    .background(gradient)
                    .cornerRadius(cornerRadius)
                    .foregroundColor(.white)
            } else {
                content
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(gradient, lineWidth: 2.0)
                    )
            }
        }
    }
}

extension Style {
    enum Role: CaseIterable {
        case primary
        case secondary
    }
}

extension View {
    func style(_ role: Style.Role, filled: Bool = true, rounded: Bool = true) -> some View {
        modifier(Style(role: role, filled: filled, rounded: rounded))
    }
    
    func blueStyle() -> some View {
        style(forTheme: .default, withRole: .primary)
    }
    
    func tealStyle() -> some View {
        style(forTheme: .web, withRole: .primary)
    }
    
    func orangeStyle(filled: Bool = true) -> some View {
        style(forTheme: .default, withRole: .secondary, filled: filled)
    }
    
    func greenStyle(filled: Bool = true) -> some View {
        style(forTheme: .web, withRole: .secondary, filled: filled)
    }
}

private extension View {
    func style(forTheme theme: Theme, withRole role: Style.Role, filled: Bool = true) -> some View {
        self
            .modifier(Style(role: role, filled: filled))
            .environment(\.theme, theme)
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
