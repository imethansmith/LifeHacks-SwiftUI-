//
//  QuestionView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 29/04/21.
//

import SwiftUI

//MARK: - QuestionView

struct QuestionView: View {
    @State var question: Question
    
    var body: some View {
        ScrollView {
            LazyVStack {
                QuestionDetails(question: $question)
                    .padding(.horizontal, 20.0)
                PaddedDivider()
                ForEach(question.answers.indices) { index in
                    AnswerDetails(answer: $question.answers[index])
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 24.0)
                    PaddedDivider()
                }
            }
        }
    }
}

extension QuestionView {
    struct PaddedDivider: View {
        var body: some View {
            Divider()
                .padding(.leading, 20.0)
        }
    }
}

//MARK: - Owner

extension QuestionView {
    struct Owner: View {
        let name: String
        let reputation: Int
        let avatar: UIImage
        
        var body: some View {
            HStack {
                RoundImage(image: avatar)
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(name)
                        .font(.headline)
                    Text("\(reputation.formatted) reputation")
                        .font(.caption)
                }
            }
            .padding(16)
        }
    }
}

extension QuestionView.Owner {
    init(user: User) {
        name = user.name
        reputation = user.reputation
        avatar = user.avatar
    }
}

//MARK: - Previews

struct QuestionView_Previews: PreviewProvider {
    typealias Owner = QuestionView.Owner
    
    static let question = TestData.question
    static let user = TestData.user
    
    static var previews: some View {
        Group {
            QuestionView(question: question)
                .fullScreenPreviews()
            Owner(user: user)
                .blueStyle()
                .previewWithName(String.name(for: Owner.self))
        }
    }
}
