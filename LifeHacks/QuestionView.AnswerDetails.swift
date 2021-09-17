//
//  QuestionView.AnswerDetails.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import SwiftUI

fileprivate typealias AnswerDetails = QuestionView.AnswerDetails

//MARK: - QuestionView.AnswerDetails
extension QuestionView {
    struct AnswerDetails: View {
        @Binding var answer: Answer
        
        @Environment(\.navigationMap) private var navigationMap
        
        var body: some View {
            HStack(alignment: .top, spacing: 16.0) {
                VStack(spacing: 16.0) {
                    QuestionView.Voting(score: answer.score,
                                        vote: .init(vote: answer.vote),
                                        upvote: { answer.upvote() },
                                        downvote: { answer.downvote() },
                                        unvote: { answer.unvote() })
                    if answer.isAccepted {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                    }
                }
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(answer.body)
                        .font(.subheadline)
                    Text("Answered on \(answer.creationDate.formatted)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack {
                        Spacer()
                        NavigationLink(destination: navigationMap.destinationForUser?(answer.owner)) {
                            QuestionView.Owner(user: answer.owner)
                                .style(.secondary)
                        }
                    }
                    .padding(.top, 16.0)
                }
            }
        }
    }
}

//MARK: - Previews
struct QuestionView_AnswerDetails_Previews: PreviewProvider {
    typealias Details = QuestionView.AnswerDetails
    
    static let answer = TestData.answer
    
    static var previews: some View {
        Details(answer: .constant(answer))
            .namedPreview()
    }
}
