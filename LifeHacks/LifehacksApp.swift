//
//  AppDelegate.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import SwiftUI

@main
struct LifehacksApp: App {
@StateObject private var stateController = StateController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateController)
        }
    }
}

extension LifehacksApp {
    struct Keys {
        static let themeName = "ThemeName"
        static let isLoggedIn = "IsLoggedIn"
    }
}
