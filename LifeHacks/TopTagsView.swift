//
//  TopTagsView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 12/05/21.
//

import SwiftUI

//MARK: - TopTagsView
struct TopTagsView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(tags: stateController.tags)
            .environment(\.navigationMap, NavigationMap(destinationForQuestion: { QuestionView(question: $0) }))
    }
}

//MARK: - Content
fileprivate typealias Content = TopTagsView.Content

extension TopTagsView {
    struct Content: View {
        let tags: [Tag]

        @Environment(\.navigationMap) private var navigationMap
        
        var body: some View {
            List {
                ForEach(tags) { tag in
                    DisclosureGroup {
                        if let questions = tag.questions {
                            ForEach(questions) { question in
                                NavigationLink(destination: navigationMap.destinationForQuestion?(question)) {
                                    QuestionRow(question: question)
                                }
                            }
                        }
                    } label: {
                        Header(title: tag.name, count: tag.count, excerpt: tag.excerpt ?? "")
                    }
                }
            }
            .navigationTitle("Tags")
        }
    }
}

//MARK: - Header
fileprivate typealias Header = TopTagsView.Header

extension TopTagsView {
    struct Header: View {
        let title: String
        let count: Int
        let excerpt: String
        
        var body: some View {
            VStack(spacing: 8.0) {
                HStack {
                    Text(title)
                    Spacer()
                    Text("\(count)")
                }
                .font(.headline)
                Text(excerpt)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.leading, -4.0)
            }
            .padding(.vertical, 8.0)
        }
    }
}

//MARK: - Previews
struct TopTagsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TopTagsView()
        }
    }
}
