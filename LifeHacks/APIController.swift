//
//  APIController.swift
//  LifeHacks
//
//  Created by Ethan Smith on 8/10/21.
//

import Foundation

class APIController: ObservableObject {
    struct StackExchangeAPI {
        static let questionsURL = URL(string: "https://api.stackexchange.com/2.2/questions")!
        static let usersURL = URL(string: "https://api.stackexchange.com/2.2/users")!
    }
    
    func loadQuestions(withCompletion completion: @escaping ([Question]?) -> Void) {
        let parameters = ["order": "desc", "sort": "activity", "site": "lifehacks", "pagesize": "10"]
        let url = StackExchangeAPI.questionsURL.appendingParameters(parameters)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let wrapper = try? JSONDecoder().decode(Wrapper<Question>.self, from: data)
            DispatchQueue.main.async { completion(wrapper?.items) }
        }
        task.resume()
    }
}
