//
//  StateController.swift
//  LifeHacks
//
//  Created by Ethan Smith on 16/09/21.
//

import Foundation
import UIKit

class StateController: ObservableObject {
    @Published private(set) var mainUser = TestData.user
    @Published var topQuestions = TestData.questions
    @Published var theme: Theme = .default
    @Published var tags = TestData.topTags
    @Published var users = TestData.users
    
    func save(name: String, aboutMe: String, avatar: UIImage) {
        mainUser.name = name
        mainUser.aboutMe = aboutMe
        mainUser.avatar = avatar
    }
}
