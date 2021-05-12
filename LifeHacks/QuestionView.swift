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
        ScrollViewReader { scrolling in
            ScrollView {
                        LazyVStack {
                            QuestionDetails(question: $question, jumpToAnswer: { jumpToAnswer(with: scrolling) })
                                .padding(.horizontal, 20.0)
                            PaddedDivider()
                            Comments(comments: question.comments)
                            PaddedDivider()
                            ForEach(question.answers.indices) { index in
                                AnswerDetails(answer: $question.answers[index])
                                    .padding(.horizontal, 20.0)
                                    .padding(.vertical, 24.0)
                                    .id(question.answers[index].id)
                                PaddedDivider()
                            }
                        }
                    }
        }
        
    }
}

private extension QuestionView {
    func jumpToAnswer(with scrolling: ScrollViewProxy) {
        guard let acceptedAnswer = question.answers.first(where: { $0.isAccepted }) else { return }
        withAnimation {
            scrolling.scrollTo(acceptedAnswer.id, anchor: .top)
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

//MARK: - Comments

extension QuestionView {
    struct Comments: View {
        let comments: [LifeHacks.Comment]
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top) {
                        ForEach(self.comments) { comment in
                            Comment(text: comment.body, ownerName: comment.owner.name)
                                .frame(width: geometry.size.width - 40.0)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .frame(height: 174.0)
            .padding(.vertical)
        }
    }
}

extension QuestionView.Comments {
    struct Comment: View {
        let text: String
        let ownerName: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(text)
                    .lineLimit(5)
                Button(action: {}) {
                    Text(ownerName)
                        .foregroundColor(.accentColor)
                }
            }
            .font(.subheadline)
            .padding(24.0)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(6.0)
        }
    }
}

//MARK: - Previews

struct QuestionView_Previews: PreviewProvider {
    typealias Owner = QuestionView.Owner
    typealias Comments = QuestionView.Comments
    typealias Comment = Comments.Comment
    
    static let question = TestData.question
    static let user = TestData.user
    static let comment = TestData.comment
    
    static var previews: some View {
        Group {
            QuestionView(question: question)
                .fullScreenPreviews()
            Owner(user: user)
                .blueStyle()
                .previewWithName(String.name(for: Owner.self))
            Comments(comments: question.comments)
                .namedPreview()
            Comment(text: comment.body, ownerName: comment.owner.name)
                .namedPreview()
        }
    }
}
