//
//  User Question Model.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - User Model

struct User: Identifiable {
    let id: Int
    var name: String
    var aboutMe: String
    let reputation: Int
    var avatar: UIImage
}

//MARK: - Question Model

struct Question: Identifiable, Votable {
    let id: Int
    let viewCount: Int
    let title: String
    let body: String
    let creationDate: Date
    let tags: [String]
    let owner: User
    let answerCount: Int
    let isAnswered: Bool
    let comments: [Comment]
    var answers: [Answer]
    var score: Int
    var vote = Vote.none
}

enum Vote: Int {
    case none = 0
    case up = 1
    case down = -1
}

//MARK: - Answer Model

struct Answer: Identifiable, Votable {
    let id: Int
    let body: String
    let creationDate: Date
    let isAccepted: Bool
    let owner: User
    var score: Int
    var vote = Vote.none
}

//MARK: - Comment Model

struct Comment: Identifiable {
    let id: Int
    let body: String
    let owner: User
}

//MARK: - Theme Model

struct Theme: Identifiable {
    let name: String
    let accentColor: Color
    let secondaryColor: Color
    let primaryGradient: LinearGradient
    let secondaryGradient: LinearGradient
    
    var id: String { name }
    
    static let `default` = Theme(
        name: "Default",
        accentColor: .blue,
        secondaryColor: .orange,
        primaryGradient: .blue,
        secondaryGradient: .orange)
    
    static let web = Theme(
        name: "Web",
        accentColor: .teal,
        secondaryColor: .green,
        primaryGradient: .teal,
        secondaryGradient: .green)
    
    static let allThemes: [Theme] = [.default, .web]
}

//MARK: - Votable Protocol

protocol Votable {
    var vote: Vote { get set }
    var score: Int { get set }
}

extension Votable {
    mutating func upvote() {
        cast(vote: .up)
    }
    
    mutating func downvote() {
        cast(vote: .down)
    }
    
    mutating func unvote() {
        score -= vote.rawValue
        vote = .none
    }
}

private extension Votable {
    mutating func cast(vote: Vote) {
        guard self.vote != vote else { return }
        unvote()
        score += vote.rawValue
        self.vote = vote
    }
}
