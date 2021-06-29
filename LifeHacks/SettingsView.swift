//
//  SettingsView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 9/05/21.
//

import SwiftUI

//MARK: - SettingsView
struct SettingsView: View {
    @State var selectedTheme: Theme = .default
    
    var body: some View {
        Form {
            Section(header: Text("APP THEME")) {
                ForEach(Theme.allThemes) { theme in
                    Row(name: theme.name, selected: theme.id == selectedTheme.id) {
                        selectedTheme = theme
                    }
                    .environment(\.theme, theme)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

//MARK: - Row
extension SettingsView {
    struct Row: View {
        let name: String
        let selected: Bool
        let tags = ["tag1", "tag2", "tag3", "tag4", "tag5"]
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    QuestionRow(title: name, tags: tags, score: 999, answerCount: 99, viewCount: 99, date: Date(), name: "Username", isAnswered: true)
                    Spacer()
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .foregroundColor(selected ? .accentColor : .clear)
                }
            }
        }
    }
}

//MARK: - Previews
struct SettingsView_Previews: PreviewProvider {
    typealias Row = SettingsView.Row
    
    static var previews: some View {
        Group {
            NavigationView {
                SettingsView()
            }
            VStack {
                Row(name: "Name", selected: false, action: {})
                Row(name: "Name", selected: true, action: {})
            }
            .previewWithName(.name(for: Row.self))
        }
    }
}
