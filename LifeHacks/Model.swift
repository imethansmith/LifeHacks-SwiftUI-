//
//  User Question Model.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import Foundation
import SwiftUI
import UIKit

//MARK: - Vote Model
enum Vote: Int, Codable {
    case none = 0
    case up = 1
    case down = -1
}

//MARK: - User Model
struct User: Identifiable {
    let id: Int
    var name: String
    var aboutMe: String?
    let reputation: Int
    var avatar: UIImage?
    let profileImageURL: URL?
    let userType: String
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case aboutMe = "about_me"
        case profileImageURL = "profile_image"
        case userType = "user_type"
        case reputation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userType = try container.decode(String.self, forKey: .userType)
        guard userType != "does_not_exist" else {
            id = 0
            reputation = 0
            name = "Deleted user"
            profileImageURL = nil
            return
        }
        id = try container.decode(Int.self, forKey: .id)
        reputation = try container.decode(Int.self, forKey: .reputation)
        name = try container.decode(String.self, forKey: .name)
        profileImageURL = try container.decodeIfPresent(URL.self, forKey: .profileImageURL)
        aboutMe = try container.decodeIfPresent(String.self, forKey: .aboutMe)?.plainHtmlString
    }
}

//MARK: - Question Model
struct Question: Identifiable, Votable {
    let id: Int
    let viewCount: Int
    let title: String
    let body: String?
    let creationDate: Date
    let tags: [String]
    let owner: User?
    let answerCount: Int
    let isAnswered: Bool
    let comments: [Comment]?
    var answers: [Answer]?
    var score: Int
    var vote = Vote.none
}

extension Question: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case isAnswered = "is_answered"
        case creationDate = "creation_date"
        case title
        case body
        case score
        case owner
        case tags
        case comments
        case answers
        case vote
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        viewCount = try container.decode(Int.self, forKey: .viewCount)
        answerCount = try container.decode(Int.self, forKey: .answerCount)
        title = try container.decode(String.self, forKey: .title).plainHtmlString
        isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        tags = try container.decode([String].self, forKey: .tags)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        comments = try container.decodeIfPresent([Comment].self, forKey: .comments)
        answers = try container.decodeIfPresent([Answer].self, forKey: .answers)
        vote = try container.decodeIfPresent(Vote.self, forKey: .vote) ?? .none
    }
}

//MARK: - Answer Model
struct Answer: Identifiable, Votable {
    let id: Int
    let body: String?
    let creationDate: Date
    let isAccepted: Bool
    let owner: User?
    var score: Int
    var vote = Vote.none
}

extension Answer: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case creationDate = "creation_date"
        case isAccepted = "is_accepted"
        case body
        case score
        case owner
        case vote
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        isAccepted = try container.decode(Bool.self, forKey: .isAccepted)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        vote = try container.decodeIfPresent(Vote.self, forKey: .vote) ?? .none
    }
}

//MARK: - Comment Model
struct Comment: Identifiable {
    let id: Int
    let body: String?
    let owner: User?
}

extension Comment: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case body
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
    }
}

//MARK: - Tag Model
struct Tag: Identifiable, Codable {
    let count: Int
    let name: String
    let excerpt: String?
    let questions: [Question]?
    
    var id: String { name }
}

extension Tag {
    struct Excerpt: Codable {
        let text: String
        
        enum CodingKeys: String, CodingKey {
            case text = "excerpt"
        }
    }
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
    
    static func named(_ name: String) -> Theme? {
        allThemes.first(where: { $0.name == name })
    }
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue = Theme.default
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
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

struct Wrapper: Decodable {
    let items: [Question]
}
