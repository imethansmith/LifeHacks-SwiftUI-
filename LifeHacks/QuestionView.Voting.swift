//
//  QuestionView Voting.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import SwiftUI


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
    init(vote: Vote) {
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


struct QuestionView_Voting_Previews: PreviewProvider {
    typealias Voting = QuestionView.Voting
    typealias VoteButton = Voting.VoteButton
    
    static let question = TestData.question
    
    static var previews: some View {
        Group {
            HStack {
                Voting(score: question.score, vote: .none, upvote: {}, downvote: {}, unvote: {})
                Voting(score: question.score, vote: .up, upvote: {}, downvote: {}, unvote: {})
                Voting(score: question.score, vote: .down, upvote: {}, downvote: {}, unvote: {})
            }
            .previewWithName(String.name(for: Voting.self))
            HStack(spacing: 16) {
                VoteButton(buttonType: .up, highlighted: true, action: {})
                VoteButton(buttonType: .up, highlighted: false, action: {})
                VoteButton(buttonType: .down, highlighted: true, action: {})
                VoteButton(buttonType: .down, highlighted: false, action: {})
            }
            .previewWithName(String.name(for: VoteButton.self))
        }
    }
}
