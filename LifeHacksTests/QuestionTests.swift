////
////  LifeHacksTests.swift
////  LifeHacksTests
////
////  Created by Ethan Smith on 28/04/21.
////
//
//import XCTest
//@testable import LifeHacks
//
//class QuestionTests: XCTestCase {
//    func testUpvote() {
//        var question = makeQuestion()
//        
//        question.upvote()
//        
//        XCTAssertEqual(question.score, 1)
//    }
//    
//    func testDownvote() {
//        var question = makeQuestion()
//        
//        question.downvote()
//        
//        XCTAssertEqual(question.score, -1)
//    }
//    
//    func testUnvote() {
//        var question = makeQuestion()
//        
//        question.upvote()
//        question.unvote()
//        
//        XCTAssertEqual(question.score, 0)
//    }
//    
//    func testVotingOnce() {
//        var question = makeQuestion()
//
//        question.upvote()
//        question.upvote()
//        
//        XCTAssertEqual(question.score, 1)
//    }
//    
//    func testReversingVote() {
//        var question = makeQuestion()
//
//        question.upvote()
//        question.downvote()
//        
//        XCTAssertEqual(question.score, -1)
//    }
//}
//
////private extension QuestionTests {
////    func makeQuestion() -> Question {
//////        let user = User(id: 1, name: "", aboutMe: "", reputation: 0, avatar: UIImage())
//////        return Question(viewCount: 0, title: "", body: "", creationDate: Date(), tags: [], owner: user, score: 0)
////    }
////}
