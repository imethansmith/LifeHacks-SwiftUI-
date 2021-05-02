//
//  QuestionView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 29/04/21.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24.0) {
            HStack(alignment: .top, spacing: 16.0) {
                Voting(score: question.score)
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

struct QuestionView_Previews: PreviewProvider {
    static let question = TestData.question
    static let user = TestData.user
    
    static var previews: some View {
        Group {
            QuestionView(question: question)

            Group {
                QuestionView.Info(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
                    .previewDisplayName("Info")
                QuestionView.Voting(score: question.score)
                    .previewDisplayName("Voting")
                HStack(spacing: 16) {
                    QuestionView.Voting.VoteButton(buttonType: .up, highlighted: true)
                    QuestionView.Voting.VoteButton(buttonType: .up, highlighted: false)
                    QuestionView.Voting.VoteButton(buttonType: .down, highlighted: true)
                    QuestionView.Voting.VoteButton(buttonType: .down, highlighted: false)
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

//MARK: - Info View

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

//MARK: - Voting

extension QuestionView {
    struct Voting: View {
        let score: Int
        
        var body: some View {
            VStack(spacing: 8.0) {
                VoteButton(buttonType: .up, highlighted: false)
                Text("\(score)")
                    .font(.title)
                    .foregroundColor(.secondary)
                VoteButton(buttonType: .down, highlighted: false)
            }
        }
    }
}

extension QuestionView.Voting {
    struct VoteButton: View {
        let buttonType: ButtonType
        let highlighted: Bool
        
        var body: some View {
            Button(action: {}) {
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
