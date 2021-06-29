//
//  TopUsersView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 12/05/21.
//

import SwiftUI

//MARK: - TopUsersView
struct TopUsersView: View {
    @ScaledMetric private var columnWidth: CGFloat = 200.0
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24.0) {
                ForEach(TestData.users) { user in
                    Cell(user: user)
                }
            }
            .padding(.top, 24.0)
        }
        .navigationTitle("Users")
    }
}

private extension TopUsersView {
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: columnWidth))]
    }
}

//MARK: - Cell
extension TopUsersView {
    struct Cell: View {
        let name: String
        let reputation: Int
        let avatar: UIImage
        
        @ScaledMetric private var avatarSize: CGFloat = 37.0
        @ScaledMetric private var spacing: CGFloat = 8.0
        
        var body: some View {
            HStack(spacing: spacing) {
                RoundImage(image: avatar)
                    .frame(width: avatarSize, height: avatarSize)
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

//MARK: - Previews
struct TopUsersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TopUsersView()
        }
        .fullScreenPreviews()
    }
}
