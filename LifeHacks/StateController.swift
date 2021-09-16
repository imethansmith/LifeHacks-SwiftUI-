//
//  StateController.swift
//  LifeHacks
//
//  Created by Ethan Smith on 16/09/21.
//

import Foundation

class StateController: ObservableObject {
    @Published var mainUser = TestData.user
    @Published var topQuestions = TestData.questions
    @Published var theme: Theme = .default
    @Published var tags = TestData.topTags
    @Published var users = TestData.users
}
