//
//  AdaptiveView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 19/06/21.
//

import SwiftUI

struct AdaptiveView<Standard: View, Large: View>: View {
    let standard: Standard
    let large: Large
    
    @Environment(\.sizeCategory) private var sizeCategory
    
    var body: some View {
        Group {
            if sizeCategory.isLarge {
                large
            } else {
                standard
            }
        }
    }
}

struct AdaptiveView_Previews: PreviewProvider {
    static let view = AdaptiveView(standard: Text("Standard"), large: Text("Large"))
    static var previews: some View {
        Group {
            view
            view.environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
    }
}
