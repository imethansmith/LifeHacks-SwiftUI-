//
//  ContentView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import SwiftUI

//MARK: - ContentView
struct ContentView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        TabView {
            NavigationView {
                TopQuestionsView()
            }
            .tabItem { Label("Top Questions", systemImage: "list.number") }
            
            NavigationView {
                TopTagsView()
            }
            .tabItem { Label("Tags", systemImage: "tag") }
            
            NavigationView {
                TopUsersView()
            }
            .tabItem { Label("Users", systemImage: "person.2") }
            
            NavigationView {
                ProfileView(user: stateController.mainUser, isMainUser: true)
            }
            .tabItem { Label("Profile", systemImage: "person.circle") }
            
            NavigationView {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
            
        }
        .accentColor(stateController.theme.accentColor)
        .environment(\.theme, stateController.theme)
    }
}

extension ContentSizeCategory {
    var isLarge: Bool {
        let largeCategories: [ContentSizeCategory] = [.accessibilityLarge,
                                                      .accessibilityExtraLarge,
                                                      .accessibilityExtraExtraLarge,
                                                      .accessibilityExtraExtraExtraLarge
        ]
        return largeCategories.contains(self)
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

