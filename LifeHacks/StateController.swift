//
//  StateController.swift
//  LifeHacks
//
//  Created by Ethan Smith on 16/09/21.
//

import Foundation
import UIKit

class StateController: ObservableObject {
    @Published private(set) var mainUser: User
    @Published var topQuestions: [Question] {
        didSet { storageController.save(topQuestions: topQuestions) }
    }
    @Published var theme: Theme = .default
    @Published var tags = TestData.topTags
    @Published var users = TestData.users
    
    private let storageController = StorageController()
    
    init() {
        topQuestions = storageController.fetchTopQuestions() ?? TestData.questions
        mainUser = storageController.fetchUser() ?? TestData.user
    }
    
    func save(name: String, aboutMe: String, avatar: UIImage) {
        mainUser.name = name
        mainUser.aboutMe = aboutMe
        mainUser.avatar = avatar
        storageController.save(user: mainUser)
    }
}
