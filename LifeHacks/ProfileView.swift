//
//  ProfileView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 28/06/21.
//

import SwiftUI

//MARK: - ProfileView
struct ProfileView: View {
    let user: User
    var isMainUser: Bool = false
    
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            Header (
                avatar: user.avatar,
                name: user.name,
                reputation: user.reputation,
                isMainUser: isMainUser)
            Text(user.aboutMe)
                .padding(.top, 16.0)
                .padding(.horizontal, 20.0)
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .primaryAction, content: { editButton })
        }
        .fullScreenCover(isPresented: $isEditing) {
            NavigationView {
                EditProfileView(user: user)
            }
        }
    }
}

private extension ProfileView {
    var editButton: Button<Text>? {
        guard isMainUser else { return nil }
        return Button(action: { isEditing = true }) {
            Text("Edit")
        }
    }
}

//MARK: - Header
fileprivate typealias Header = ProfileView.Header
extension ProfileView {
    struct Header: View {
        let avatar: UIImage
        let name: String
        let reputation: Int
        var isMainUser: Bool = false
        
        var body: some View {
            HStack {
                Spacer()
                VStack(spacing: 4.0) {
                    RoundImage(image: avatar)
                        .frame(width: 144, height: 144)
                    Text(name)
                        .font(.title)
                        .bold()
                        .padding(.top, 12.0)
                    Text("\(reputation.formatted) reputation")
                        .font(.headline)
                }
                Spacer()
            }
            .padding([.top, .bottom], 24)
            .style(isMainUser ? .primary : .secondary, rounded: false)
        }
    }
}

//MARK: - Previews
struct ProfileView_Previews: PreviewProvider {
    static let user = TestData.user
    static let otherUser = TestData.otherUser
    
    static var previews: some View {
        Group {
            NavigationView {
                ProfileView(user: user, isMainUser: true)
            }
            .fullScreenPreviews()
            VStack {
                Header(avatar: otherUser.avatar, name: otherUser.name, reputation: otherUser.reputation)
                Header(avatar: user.avatar, name: user.name, reputation: user.reputation, isMainUser: true)
            }
            .previewWithName(.name(for: Header.self))
        }
    }
}
