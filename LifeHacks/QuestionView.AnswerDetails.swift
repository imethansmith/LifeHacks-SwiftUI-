//
//  QuestionView.AnswerDetails.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import SwiftUI

extension QuestionView {
    struct AnswerDetails: View {
        @Binding var answer: Answer
        
        var body: some View {
            HStack(alignment: .top, spacing: 16.0) {
                VStack(spacing: 16.0) {
                    QuestionView.Voting(score: answer.score, vote: .init(vote: answer.vote), upvote: { answer.upvote() }, downvote: { answer.downvote() }, unvote: { answer.unvote() })
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
                        QuestionView.Owner(user: answer.owner)
                            .orangeStyle()
                    }
                    .padding(.top, 16.0)
                }
            }
        }
    }
}
struct QuestionView_AnswerDetails_Previews: PreviewProvider {
    typealias Details = QuestionView.AnswerDetails
    
    static let answer = TestData.answer
    
    static var previews: some View {
        Details(answer: .constant(answer))
            .namedPreview()
    }
}
