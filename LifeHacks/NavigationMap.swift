//
//  NavigationMap.swift
//  LifeHacks
//
//  Created by Ethan Smith on 16/09/21.
//

import Foundation
import SwiftUI

struct NavigationMap {
    var destinationForQuestion: ((Question) -> QuestionView)?
    var destinationForUser: ((User) -> ProfileView)?
}

extension NavigationMap {
    struct Key: EnvironmentKey {
        static let defaultValue = NavigationMap()
    }
}

extension EnvironmentValues {
    var navigationMap: NavigationMap {
        get { self[NavigationMap.Key.self] }
        set { self[NavigationMap.Key.self] = newValue }
    }
}
