//
//  TopQuestionsView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 7/05/21.
//

import SwiftUI

struct TopQuestionsView: View {
    @State var questions: [Question]
    
    var body: some View {
        List {
            ForEach(questions) { question in
                Row(question: question)
            }
            .onDelete(perform: deleteItems(atOffsets:))
        }
    }
    
    func deleteItems(atOffsets offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }
}

//MARK: - Row

extension TopQuestionsView {
    struct Row: View {
        let title: String
        let tags: [String]
        let score: Int
        let answerCount: Int
        let viewCount: Int
        let date: Date
        let name: String
        let isAnswered: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                TagsView(tags: tags)
                HStack(alignment: .center, spacing: 16) {
                    Counter(count: score, label: "votes")
                        .blueStyle()
                    Counter(count: answerCount, label: "answers")
                        .orangeStyle(filled: isAnswered)
                    Details(viewCount: viewCount, date: date, name: name)
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 16)
            .padding(.leading, 4)
        }
    }
}

extension TopQuestionsView.Row {
    init(question: Question) {
        self.init(
            title: question.title,
            tags: question.tags,
            score: question.score,
            answerCount: question.answerCount,
            viewCount: question.viewCount,
            date: question.creationDate,
            name: question.owner.name,
            isAnswered: question.isAnswered)
    }
}

//MARK: - Counter

extension TopQuestionsView.Row {
    struct Counter: View {
        let count: Int
        let label: String
        
        var body: some View {
            VStack {
                Text("\(count)")
                    .font(.title3)
                    .bold()
                Text(label)
                    .font(.caption)
            }
            .frame(width: 67, height: 67)
        }
    }
}

//MARK: - Details

extension TopQuestionsView.Row {
    struct Details: View {
        let viewCount: Int
        let date: Date
        let name: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                Text("\(viewCount.formatted) views")
                Text("Asked on \(date.formatted)")
                Text(name)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

//MARK: - Previews

struct TopQuestionsView_Previews: PreviewProvider {
    typealias Row = TopQuestionsView.Row
    typealias Counter = TopQuestionsView.Row.Counter
    typealias Details = TopQuestionsView.Row.Details
    
    static let question = TestData.question
    static let questions = TestData.questions
    
    static var previews: some View {
        Group {
            TopQuestionsView(questions: questions)
                .fullScreenPreviews()
            Row(question: question)
                .namedPreview()
            Details(viewCount: question.viewCount, date: question.creationDate, name: question.owner.name)
                .namedPreview()
            HStack {
                Counter(count: question.score, label: "votes")
                    .blueStyle()
                Counter(count: question.answerCount, label: "answers")
                    .orangeStyle(filled: true)
                Counter(count: question.answerCount, label: "answers")
                    .orangeStyle(filled: false)
            }
            .previewWithName(.name(for: Counter.self))
        }
    }
}
