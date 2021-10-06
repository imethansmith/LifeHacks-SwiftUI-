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
        avatar: #imageLiteral(resourceName: "Avatar"),
        profileImageURL: URL(string: "example.com"),
        userType: ""
    )
    static let otherUser = makeUser(id: 1)
    static let users = [makeUser(id: 1), makeUser(id: 2), makeUser(id: 3), makeUser(id: 4), makeUser(id: 5)]
    static var question: Question { questions.first! }
    static let questions: [Question] = {
        let url = Bundle.main.url(forResource: "Questions", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let wrapper = try! JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper.items
    }()
    static let tag = makeTag(id: 0)
    static let topTags = [makeTag(id: 1), makeTag(id: 2), makeTag(id: 3)]
    static var comment: Comment { questions.first!.comments!.first! }
    static var answer: Answer { questions.first!.answers!.first! }
    
    static func makeUser(id: Int) -> User {
        User(id: id, name: "Martin Abasto", aboutMe: longText, reputation: 986, avatar: #imageLiteral(resourceName: "Other"), profileImageURL: URL(string: "example.com")!, userType: "")
    }
    
    static func makeTag(id: Int) -> Tag {
        Tag(count: 123, name: "Lorem", excerpt: shortText, questions: questions)
    }
}
