//
//  Type Extensions.swift
//  LifeHacks
//
//  Created by Ethan Smith on 29/04/21.
//

import Foundation
import SwiftUI

//MARK: - Preview Name and Formatter
extension View {
    func previewWithName(_ name: String) -> some View {
        self
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
    }
    
    func namedPreview() -> some View {
        let name = String.name(for: type(of: self))
        return previewWithName(name)
    }
    
    func fullScreenPreviews(showAll: Bool = false) -> some View {
        Group {
            if !showAll {
                self
            } else {
                ForEach(Theme.allThemes) { theme in
                    ForEach(ColorScheme.allCases) { colorScheme in
                        self
                            .previewTheme(theme, colorScheme: colorScheme)
                    }
                }
                self
                    .xxxlPreview()
                self
                    .iPhoneSEPreview()
            }
        }
    }
    
    func previewTheme(_ theme: Theme, colorScheme: ColorScheme) -> some View {
        self
            .background(Color(.systemBackground))
            .environment(\.theme, theme)
            .accentColor(theme.accentColor)
            .previewDisplayName(theme.name + ", " + colorScheme.name)
            .environment(\.colorScheme, colorScheme)
    }
    
    func xxxlPreview() -> some View {
        self
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Accessibility XXXL")
    }
    
    func iPhoneSEPreview() -> some View {
        self
            .previewDevice("iPhone SE (2nd generation)")
            .previewDisplayName("iPhone SE (2nd generation)")
    }
    
    // Old, basic fullScreenPreviews with less loading overhead
    // Use in case above load is not yet needed, or too expensive.
//    func fullScreenPreviews() -> some View {
//        Group {
//            self
//            self
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewDisplayName("Dark mode")
//            self
//                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
//                .previewDisplayName("Accessibility XXXL")
//            self
//                .previewDevice("iPhone SE")
//                .previewDisplayName("iPhone SE")
//        }
//    }
}

extension ColorScheme: Identifiable {
    public var id: String { name }
    
    var name: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        @unknown default:
            fatalError()
        }
    }
}

//MARK: - Get Component Name
extension String {
    static func name<T>(for type: T) -> String {
        String(reflecting: type)
            .components(separatedBy: ".")
            .last ?? ""
    }
}

//MARK: - Logic Formatters
extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

//MARK: - htmlString - format html text into clean NSAttributedString
extension String {
    var htmlString: NSAttributedString? {
        guard let htmlData = self.data(using: .unicode) else { return nil }
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: .none)
    }
    
    var plainHtmlString: String {
        return htmlString?.string ?? ""
    }
}
