//
//  TestData.swift
//  LifeHacks
//
//  Created by Ethan Smith on 10/05/21.
//

import Foundation

struct TestData {
    static let shortText = "She suspicion dejection saw instantly. Well deny may real one told yet saw hard dear."
    static let longText = "Bed chief house rapid right the. Set noisy one state tears which. No girl oh part must fact high my he. Simplicity in excellence melancholy as remarkably discovered. Own partiality motionless was old excellence she inquietude contrasted."
    static let tags = ["monkey", "rope", "found", "all", "whalers"]
    static let user = User(
        id:0,
        name: "Betty Vasquez",
        aboutMe: longText,
        reputation: 1234,
        avatar: #imageLiteral(resourceName: "Avatar")
    )
    static let otherUser = makeUser(id: 1)
    static let users = [makeUser(id: 1), makeUser(id: 2), makeUser(id: 3), makeUser(id: 4), makeUser(id: 5)]
    static var question = makeQuestion(id: 0)
    static let questions: [Question] = {
        let url = Bundle.main.url(forResource: "Questions", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        return try! PropertyListDecoder().decode([Question].self, from: data)
    }()
    static let answer = makeAnswer(id: 0, isAccepted: true)
    static let comment = makeComment(id: 0)
    
    static let tag = makeTag(id: 0)
    static let topTags = [makeTag(id: 1), makeTag(id: 2), makeTag(id: 3)]
    
    static func makeUser(id: Int) -> User {
        User(id: id, name: "Martin Abasto", aboutMe: longText, reputation: 986, avatar: #imageLiteral(resourceName: "Other"))
    }
    
    static func makeComment(id: Int) -> Comment {
        Comment(id: id, body: longText, owner: otherUser)
    }
    
    static func makeTag(id: Int) -> Tag {
        Tag(id: id, count: 123, name: "Lorem", excerpt: shortText, questions: questions)
    }
    
    static func makeAnswer(id: Int, isAccepted: Bool = false) -> Answer {
        Answer(id: id, body: longText, creationDate: Date(), isAccepted: isAccepted, owner: otherUser, score: 112)
    }
    
    static func makeQuestion(id: Int) -> Question {
        Question(
            id: id,
            viewCount: 2770,
            title: shortText,
            body: longText,
            creationDate: Date(),
            tags: tags,
            owner: user,
            answerCount: 6,
            isAnswered: true,
            comments: [makeComment(id: 1), makeComment(id: 2), makeComment(id: 3)],
            answers: [makeAnswer(id: 1, isAccepted: true), makeAnswer(id: 2), makeAnswer(id: 3)],
            score: 359
        )
    }
}
