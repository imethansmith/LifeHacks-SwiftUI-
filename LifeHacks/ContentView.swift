//
//  ContentView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import SwiftUI

//MARK: - ContentView
struct ContentView: View {
    @State private var isLoggingIn = false
    @EnvironmentObject private var stateController: StateController
    @EnvironmentObject private var settingsController: SettingsController
    @AppStorage(LifehacksApp.Keys.isLoggedIn) private var isLoggedIn = false
    @SceneStorage("ContentView.SelectedTab") private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                TopQuestionsView()
            }
            .tabItem { Label("Top Questions", systemImage: "list.number") }
            .tag(0)
            NavigationView {
                TopTagsView()
            }
            .tabItem { Label("Tags", systemImage: "tag") }
            .tag(1)
            NavigationView {
                TopUsersView()
            }
            .tabItem { Label("Users", systemImage: "person.2") }
            .tag(2)
            NavigationView {
                ProfileView(user: stateController.mainUser, isMainUser: true)
            }
            .tabItem { Label("Profile", systemImage: "person.circle") }
            .tag(3)
            NavigationView {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
            .tag(4)
        }
        .accentColor(settingsController.theme.accentColor)
        .environment(\.theme, settingsController.theme)
        .onAppear { isLoggingIn = !isLoggedIn}
        .fullScreenCover(isPresented: $isLoggingIn) {
            LoginView()
                .accentColor(settingsController.theme.accentColor)
        }
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

