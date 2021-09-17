//
//  QuestionView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 29/04/21.
//

import SwiftUI

//MARK: - QuestionView
struct QuestionView: View {
    let question: Question
    
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(question: $stateController.topQuestions[index(for: question)])
            .environment(\.navigationMap, NavigationMap(destinationForUser: destination(for:)))
    }
}

private extension QuestionView {
    func index(for question: Question) -> Int {
        stateController.topQuestions.firstIndex(where: { $0.id == question.id }) ?? 0
    }
    
    func destination(for user: User) -> ProfileView {
        ProfileView(user: user, isMainUser: user.id == stateController.mainUser.id)
    }
}

//MARK: - Content
fileprivate typealias Content = QuestionView.Content

private extension QuestionView {
    struct Content: View {
        @Binding var question: Question
        
        var body: some View {
            ScrollViewReader { scrolling in
                ScrollView {
                    LazyVStack {
                        QuestionDetails(question: $question,
                                        jumpToAnswer: { jumpToAnswer(with: scrolling) })
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
}

private extension QuestionView.Content {
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
fileprivate typealias Comments = QuestionView.Comments

extension QuestionView {
    struct Comments: View {
        let comments: [LifeHacks.Comment]
        
        var body: some View {
            GeometryReader { geometry in
                TabView {
                    ForEach(self.comments) { comment in
                        Comment(comment: comment)
                            .frame(width: geometry.size.width - 40.0)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .frame(height: 174.0)
            .padding(.vertical)
        }
    }
}

//MARK: - Comment
extension Comments {
    struct Comment: View {
        let comment: LifeHacks.Comment
        
        @Environment(\.navigationMap) private var navigationMap
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(comment.body)
                    .lineLimit(5)
                Button(action: {}) {
                    NavigationLink(destination: navigationMap.destinationForUser?(comment.owner)) {
                        Text(comment.owner.name)
                            .foregroundColor(.accentColor)
                    }
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
            NavigationView {
                QuestionView(question: question)
            }
            .fullScreenPreviews(showAll: true)
            Owner(user: user)
                .style(.primary)
                .previewWithName(.name(for: Owner.self))
            Comments(comments: question.comments)
                .previewLayout(.sizeThatFits)
                .previewDisplayName(.name(for: Comments.self))
            Comment(comment: comment)
                .namedPreview()
        }
    }
}
