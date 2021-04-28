//
//  LifeHacksTests.swift
//  LifeHacksTests
//
//  Created by Ethan Smith on 28/04/21.
//

import XCTest
@testable import LifeHacks

class QuestionTests: XCTestCase {

    func testUpvote() {
        let user = User(name: "", aboutMe: "", reputation: 0, avatar: UIImage())
        var question = Question(viewCount: 0, title: "", body: "", creationDate: Date(), tags: [], owner: user, score: 0)
        
        question.upvote()
        
        XCTAssertEqual(question.score, 1)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
