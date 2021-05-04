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
        VStack(alignment: .leading, spacing: 24.0) {
            HStack(alignment: .top, spacing: 16.0) {
                Voting(score: question.score, vote: .init(vote: question.vote), upvote: { question.upvote() }, downvote: { question.downvote() }, unvote: { question.unvote() } )
                Info(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
            }
            Text(question.body)
                .font(.subheadline)
            HStack {
                Spacer()
                Owner(name: question.owner.name, reputation: question.owner.reputation, avatar: question.owner.avatar)
            }
            Spacer()
        }
        .padding()
    }
}

//MARK: - Info

extension QuestionView {
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

//MARK: - Voting

extension QuestionView {
    struct Voting: View {
        let score: Int
        let vote: Vote
        let upvote: () -> Void
        let downvote: () -> Void
        let unvote: () -> Void
        
        var body: some View {
            VStack(spacing: 8.0) {
                VoteButton(buttonType: .up, highlighted: vote == .up, action: { vote(.up) })
                Text("\(score)")
                    .font(.title)
                    .foregroundColor(.secondary)
                VoteButton(buttonType: .down, highlighted: vote == .down, action: { vote(.down) })
            }
            .frame(minWidth: 56.0)
        }
        
        func vote(_ vote: Vote) {
            switch (self.vote, vote) {
            case (.none, .up), (.down, .up): upvote()
            case (.none, .down), (.up, .down): downvote()
            default: unvote()
            }
        }
    }
}

extension QuestionView.Voting {
    enum Vote {
        case none
        case up
        case down
    }
}

extension QuestionView.Voting.Vote {
    init(vote: Question.Vote) {
        switch vote {
        case .none: self = .none
        case .up: self = .up
        case .down: self = .down
        }
    }
}

//MARK: - VoteButton

extension QuestionView.Voting {
    struct VoteButton: View {
        let buttonType: ButtonType
        let highlighted: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                buttonType.image(highlighted: highlighted)
                    .resizable()
                    .frame(width:32, height: 32)
                    .foregroundColor(.orange)
            }
        }
    }
}

extension QuestionView.Voting.VoteButton {
    enum ButtonType: String {
        case up = "arrowtriangle.up"
        case down = "arrowtriangle.down"
        
        func image(highlighted: Bool) -> Image {
            let imageName = rawValue + (highlighted ? ".fill" : "")
            return Image(systemName: imageName)
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
            .blueStyle()
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

//MARK: - TestData

struct TestData {
    static let user = User(
        name: "Betty Vasquez",
        aboutMe: "Affronting imprudence do he he everything. Sex lasted dinner wanted indeed wished out law. Far advanced settling say finished raillery. Offered chiefly farther of my no colonel shyness.",
        reputation: 1234,
        avatar: #imageLiteral(resourceName: "Avatar")
    )
    
    static let question = Question(
        viewCount: 2770,
        title: "She suspicion dejection saw instantly. Well deny may real one told yet saw hard dear.",
        body: "Bed chief house rapid right the. Set noisy one state tears which. No girl oh part must fact high my he. Simplicity in excellence melancholy as remarkably discovered. Own partiality motionless was old excellence she inquietude contrasted. ",
        creationDate: Date(),
        tags: ["monkey", "rope", "found", "all", "whalers"],
        owner: user,
        score: 359
    )
}

//MARK: - Previews

struct QuestionView_Previews: PreviewProvider {
    static let question = TestData.question
    static let user = TestData.user
    
    static var previews: some View {
        Group {
            QuestionView(question: question)
            QuestionView(question: question)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
            QuestionView(question: question)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Accessibility XXXL")
            QuestionView(question: question)
                .previewDevice(/*@START_MENU_TOKEN@*/"iPhone SE (2nd generation)"/*@END_MENU_TOKEN@*/)
                .previewDisplayName("iPhone SE")
            Group {
                QuestionView.Info(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
                    .previewDisplayName("Info")
                HStack {
                    QuestionView.Voting(score: question.score, vote: .none, upvote: {}, downvote: {}, unvote: {})
                    QuestionView.Voting(score: question.score, vote: .up, upvote: {}, downvote: {}, unvote: {})
                    QuestionView.Voting(score: question.score, vote: .down, upvote: {}, downvote: {}, unvote: {})
                }
                .previewDisplayName("Voting")
                HStack(spacing: 16) {
                    QuestionView.Voting.VoteButton(buttonType: .up, highlighted: true, action: {})
                    QuestionView.Voting.VoteButton(buttonType: .up, highlighted: false, action: {})
                    QuestionView.Voting.VoteButton(buttonType: .down, highlighted: true, action: {})
                    QuestionView.Voting.VoteButton(buttonType: .down, highlighted: false, action: {})
                }
                .previewDisplayName("Vote button configurations")
                QuestionView.Owner(name: user.name, reputation: user.reputation, avatar: user.avatar)
                    .padding()
                    .previewDisplayName("Owner")
            }
            .previewLayout(.sizeThatFits)
        }
    }
}
