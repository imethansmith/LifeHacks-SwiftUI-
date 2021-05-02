//
//  ContentView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        QuestionView(question: TestData.question)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
