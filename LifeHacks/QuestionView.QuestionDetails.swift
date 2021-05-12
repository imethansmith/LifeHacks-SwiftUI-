//
//  QuestionView.QuestionDetails.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import SwiftUI

extension QuestionView {
    struct QuestionDetails: View {
        @Binding var question: Question
        let jumpToAnswer: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 24.0) {
                HStack(alignment: .top, spacing: 16.0) {
                    QuestionView.Voting(
                        score: question.score,
                        vote: .init(vote: question.vote),
                        upvote: { question.upvote() },
                        downvote: { question.downvote() },
                        unvote: { question.unvote() }
                    )
                    Info(
                        title: question.title,
                        viewCount: question.viewCount,
                        date: question.creationDate,
                        tags: question.tags
                    )
                }
                if question.isAnswered {
                    Button("Go to accepted answer", action: jumpToAnswer)
                        .font(Font.footnote.bold())
                }
                Text(question.body)
                    .font(.subheadline)
                HStack {
                    Spacer()
                    QuestionView.Owner(user: question.owner)
                        .blueStyle()
                }
            }
        }
    }
}

//MARK: - Info

extension QuestionView.QuestionDetails {
    struct Info: View {
        let title: String
        let viewCount: Int
        let date: Date
        let tags: [String]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.headline)
                TagsView(tags: tags)
                Group {
                    Text("Asked on \(date.formatted)")
                    Text("Viewed \(viewCount.formatted) times")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}

struct QuestionView_QuestionDetails_Previews: PreviewProvider {
    typealias QuestionDetails = QuestionView.QuestionDetails
    typealias Info = QuestionDetails.Info
    
    static let question = TestData.question
    
    static var previews: some View {
        Group {
            QuestionDetails(question: .constant(question))
                .namedPreview()
            Info(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
                .namedPreview()
        }
    }
}
