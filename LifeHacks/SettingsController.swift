//
//  SettingsController.swift
//  LifeHacks
//
//  Created by Ethan Smith on 2/10/21.
//

import Foundation

class SettingsController: ObservableObject {
    @Published var theme: Theme {
        didSet { defaults.set(theme.name, forKey: LifehacksApp.Keys.themeName)}
    }
    
    private let defaults = UserDefaults.standard
    
    init() {
        let themeName = defaults.string(forKey: LifehacksApp.Keys.themeName) ?? ""
        theme = Theme.named(themeName) ?? .default
    }
}
