//
//  EditProfileView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 5/05/21.
//

import SwiftUI

//MARK: - EditProfileView
struct EditProfileView: View {
    @State var user: User
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Header(name: $user.name, avatar: user.avatar)
            AboutMe(text: $user.aboutMe)
            Spacer()
        }
        .padding(20.0)
        .navigationTitle("Edit Profile")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", action: dismiss)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: dismiss)
            }
        }
    }
}

private extension EditProfileView {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

//MARK: - Header
extension EditProfileView {
    struct Header: View {
        @Binding var name: String
        var avatar: UIImage
        
        @State private var pickingSource: Bool = false
        
        var body: some View {
            HStack(alignment: .top) {
                ZStack {
                    RoundImage(image: avatar, borderColor: Color.accentColor)
                        .frame(width: 62.0, height: 62.0)
                    Button(action: { self.pickingSource = true }) {
                        Text("Edit")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                VStack(alignment: .leading) {
                    TextField("Name", text: $name)
                    Divider()
                    EditProfileView.ErrorMessage(text: "Your name cannot be empty", isVisible: name.isEmpty)
                }
                .padding(.leading, 16.0)
            }
            .actionSheet(isPresented: $pickingSource) {
                ActionSheet(title: Text("Select a source"), message: Text(""), buttons: [
                    .default(Text("Take photo"), action: {} ),
                    .default(Text("Choose from Library"), action: {} ),
                    .cancel()
                ])
            }
        }
    }
}

//MARK: - About Me
extension EditProfileView {
    struct AboutMe: View {
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("About me:")
                    .font(.callout)
                    .bold()
                MultilineTextField(text: $text)
                    .frame(height: 200.0)
                EditProfileView.ErrorMessage(text: "Your About section cannot be empty", isVisible: text.isEmpty)
            }
        }
    }
}

//MARK: - Error Message
extension EditProfileView {
    struct ErrorMessage: View {
        let text: String
        var isVisible: Bool = false
        
        var body: some View {
            Group {
                if isVisible {
                    Text(text)
                        .font(.footnote)
                        .bold()
                        .motif(.secondary)
                }
            }
        }
    }
}

//MARK: - Preview
struct EditProfileView_Previews: PreviewProvider {
    typealias Header = EditProfileView.Header
    typealias AboutMe = EditProfileView.AboutMe
    typealias ErrorMessage = EditProfileView.ErrorMessage
    
    static let user = TestData.user
    
    static var previews: some View {
        Group {
            NavigationView {
                EditProfileView(user: TestData.user)
            }
            .fullScreenPreviews()
            VStack(spacing: 16.0) {
                Header(name: .constant(user.name), avatar: user.avatar)
                Header(name: .constant(""), avatar: user.avatar)
            }
            .previewWithName(.name(for: Header.self))
            VStack(spacing: 16.0) {
                AboutMe(text: .constant(user.aboutMe))
                AboutMe(text: .constant(""))
            }
            .previewWithName(.name(for: AboutMe.self))
            EditProfileView.ErrorMessage(text: "The name cannot be empty", isVisible: true)
                .namedPreview()
        }
    }
}
