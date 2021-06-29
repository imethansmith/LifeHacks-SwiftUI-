//
//  QuestionView.QuestionDetails.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import SwiftUI

fileprivate typealias QuestionDetails = QuestionView.QuestionDetails

extension QuestionView {
    struct QuestionDetails: View {
        @Binding var question: Question
        let jumpToAnswer: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 24.0) {
                AdaptiveView(standard: HStack(alignment: .top, spacing: 16.0) { topContent },
                             large: VStack { topContent })
                if question.isAnswered {
                    Button("Go to accepted answer", action: jumpToAnswer)
                        .font(Font.footnote.bold())
                }
                Text(question.body)
                    .font(.subheadline)
                HStack {
                    AdaptiveView(standard: Spacer(), large: EmptyView())
                    Spacer()
//                    NavigationLink(destination: ProfileView(user: question.owner, isMainUser: true))
                    QuestionView.Owner(user: question.owner)
                        .style(.primary)
                }
            }
        }
    }
}

//MARK: - topContent
extension QuestionDetails {
    var topContent: some View {
        Group {
            QuestionView.Voting(score: question.score,
                                vote: .init(vote: question.vote),
                                upvote: { },
                                downvote: { },
                                unvote: { })
            Info(title: question.title,
                 viewCount: question.viewCount,
                 date: question.creationDate,
                 tags: question.tags)
        }
    }
}

//MARK: - Info
extension QuestionDetails {
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

//MARK: - Previews
struct QuestionView_QuestionDetails_Previews: PreviewProvider {
    fileprivate typealias Info = QuestionDetails.Info
    
    static let question = TestData.question
    
    static var previews: some View {
        Group {
            QuestionDetails(question: .constant(question), jumpToAnswer: {})
                .namedPreview()
            QuestionDetails(question: .constant(question), jumpToAnswer: {})
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewWithName(String.name(for: QuestionDetails.self) + "XXXL")
            Info(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
                .namedPreview()
        }
    }
}
