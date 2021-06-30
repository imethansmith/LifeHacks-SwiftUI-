//
//  TopTagsView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 12/05/21.
//

import SwiftUI

//MARK: - TopTagsView
struct TopTagsView: View {
    let tags: [Tag]
    
    var body: some View {
        List {
            ForEach(tags) { tag in
                DisclosureGroup {
                    ForEach(tag.questions) { question in
                        NavigationLink(destination: QuestionView(question: question)) {
                            QuestionRow(question: question)
                        }
                    }
                } label: {
                    Header(title: tag.name, count: tag.count, excerpt: tag.excerpt)
                }
            }
        }
        .navigationTitle("Tags")
    }
}

//MARK: - Header
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
            TopTagsView(tags: TestData.topTags)
        }
    }
}
