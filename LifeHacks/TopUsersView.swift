//
//  TopUsersView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 12/05/21.
//

import SwiftUI

struct TopUsersView: View {
    private let columns = [GridItem(.adaptive(minimum: 200))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24.0) {
                ForEach(TestData.users) { user in
                    Cell(user: user)
                }
            }
            .padding(.top, 24.0)
        }
    }
}

extension TopUsersView {
    struct Cell: View {
        let name: String
        let reputation: Int
        let avatar: UIImage
        
        var body: some View {
            HStack {
                RoundImage(image: avatar)
                    .frame(width: 37.0, height: 37.0)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Text(name)
                    .font(.subheadline)
                    .bold()
                Text("\(reputation.formatted) reputation")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

extension TopUsersView.Cell {
    init(user: User) {
        name = user.name
        reputation = user.reputation
        avatar = user.avatar
    }
}

struct TopUsersView_Previews: PreviewProvider {
    static var previews: some View {
        TopUsersView()
    }
}
