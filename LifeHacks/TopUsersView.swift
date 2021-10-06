//
//  TopUsersView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 12/05/21.
//

import SwiftUI

//MARK: - TopUsersView
struct TopUsersView: View {
    @EnvironmentObject private var stateController: StateController
    
    var body: some View {
        Content(users: stateController.users)
            .environment(\.navigationMap, NavigationMap(destinationForUser: { ProfileView(user: $0) }))
    }
}

//MARK: - Content
fileprivate typealias Content = TopUsersView.Content

extension TopUsersView {
    struct Content: View {
        let users: [User]
        
        @ScaledMetric private var columnWidth: CGFloat = 200.0
        @Environment(\.navigationMap) private var navigationMap
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24.0) {
                    ForEach(users) { user in
                        NavigationLink(destination: navigationMap.destinationForUser?(user)) {
                            Cell(user: user)
                        }
                    }
                }
                .padding(.top, 24.0)
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Users")
        }
    }
}


private extension Content {
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
        avatar = user.avatar ?? UIImage()
    }
}

//MARK: - Previews
struct TopUsersView_Previews: PreviewProvider {
    static let users = TestData.users
    
    static var previews: some View {
        NavigationView {
            TopUsersView()
        }
        .fullScreenPreviews()
    }
}
