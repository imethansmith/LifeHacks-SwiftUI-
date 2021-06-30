//
//  ContentView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import SwiftUI

//MARK: - ContentView
struct ContentView: View {
    let questions = TestData.questions
    let tags = TestData.topTags
    let users = TestData.users
    let user = TestData.user
    
    var body: some View {
        TabView {
            NavigationView {
                TopQuestionsView(questions: questions)
            }
            .tabItem { Label("Top Questions", systemImage: "list.number") }
            
            NavigationView {
                TopTagsView(tags: tags)
            }
            .tabItem { Label("Tags", systemImage: "tag") }
            
            NavigationView {
                TopUsersView(users: users)
            }
            .tabItem { Label("Users", systemImage: "person.2") }
            
            NavigationView {
                ProfileView(user: user, isMainUser: true)
            }
            .tabItem { Label("Profile", systemImage: "person.circle") }
            
            NavigationView {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
            
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

