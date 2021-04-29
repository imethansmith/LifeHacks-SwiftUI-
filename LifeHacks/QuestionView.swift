//
//  QuestionView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 29/04/21.
//

import SwiftUI

struct QuestionView: View {
    let title: String
    let viewCount: Int
    let date: Date
    let tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(title)
                .font(.headline)
            Text(tagsString)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Group {
                Text("Asked on \(date.formatted)")
                Text("Viewed \(viewCount.formatted) times")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static let question = TestData.question
    
    static var previews: some View {
        QuestionView(title: question.title, viewCount: question.viewCount, date: question.creationDate, tags: question.tags)
    }
}

private extension QuestionView {
    var tagsString: String {
        var result = tags.first ?? ""
        for tag in tags.dropFirst() {
            result.append(", " + tag)
        }
        return result
    }
}

//MARK: - TestData

struct TestData {
    static let user = User(
        name: "Betty Vasquez",
        aboutMe: "Affronting imprudence do he he everything. Sex lasted dinner wanted indeed wished out law. Far advanced settling say finished raillery. Offered chiefly farther of my no colonel shyness.",
        reputation: 1234,
        avatar: UIImage()
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
