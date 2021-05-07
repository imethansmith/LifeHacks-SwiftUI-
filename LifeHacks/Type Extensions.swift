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
    
    func fullScreenPreviews() -> some View {
        Group {
            self
            self
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
            self
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Accessibility XXXL")
            self
                .previewDevice("iPhone SE")
                .previewDisplayName("iPhone SE")
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
