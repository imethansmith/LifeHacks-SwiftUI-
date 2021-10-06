//
//  EditProfileView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 5/05/21.
//

import SwiftUI
import UIKit

struct EditProfileView: View {
    @EnvironmentObject private var stateController: StateController
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var aboutMe: String = ""
    @State private var avatar: UIImage = .init()
    
    @State private var pickingSource: Bool = false
    @State private var pickingImage: Bool = false
    @State private var source: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        Content(name: $name, aboutMe: $aboutMe, avatar: avatar, save: save, cancel: dismiss) {
            pickingSource = true
        }
        .onAppear {
            let user = stateController.mainUser
            name = user.name
            aboutMe = user.aboutMe ?? ""
            avatar = user.avatar ?? UIImage()
        }
        .actionSheet(isPresented: $pickingSource) {
            ActionSheet(title: Text("Select a source"), message: Text(""), buttons: [
                .default(Text("Take a photo"), action: { }),
                .default(Text("Choose from library"), action: { }),
                .cancel()
            ])
        }
        .sheet(isPresented: $pickingImage) {
            ImagePicker(source: source, image: $avatar)
        }
    }
}

private extension EditProfileView {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func save() {
        stateController.save(name: name, aboutMe: aboutMe, avatar: avatar)
        dismiss()
    }
    
    func takePhoto() {
        // This crashes the iOS Simulator
        source = .camera
        pickingImage = true
    }
    
    func pickPhoto() {
        source = .photoLibrary
        pickingImage = true
    }
}


//MARK: - Content
fileprivate typealias Content = EditProfileView.Content

extension EditProfileView {
    struct Content: View {
        @Binding var name: String
        @Binding var aboutMe: String
        let avatar: UIImage
        
        let save: () -> Void
        let cancel: () -> Void
        let edit: () -> Void
        
        var body: some View {
            VStack {
                Header(name: $name, avatar: avatar, edit: edit)
                AboutMe(text: $aboutMe)
                Spacer()
            }
            .padding(20.0)
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: cancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                }
            }
        }
    }
}


//MARK: - Header
extension Content {
    struct Header: View {
        @Binding var name: String
        var avatar: UIImage
        let edit: () -> Void
        
        @State private var pickingSource: Bool = false
        
        var body: some View {
            HStack(alignment: .top) {
                ZStack {
                    RoundImage(image: avatar, borderColor: Color.accentColor)
                        .frame(width: 62.0, height: 62.0)
                    Button(action: edit) {
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
    typealias Header = EditProfileView.Content.Header
    typealias AboutMe = EditProfileView.AboutMe
    typealias ErrorMessage = EditProfileView.ErrorMessage
    
    static let user = TestData.user
    
    static var previews: some View {
        Group {
            NavigationView {
                Content(
                    name: .constant(user.name), aboutMe: .constant(user.aboutMe!), avatar: user.avatar!, save: {}, cancel: {}, edit: {})
            }
            .fullScreenPreviews()
            VStack(spacing: 16.0) {
                Header(name: .constant(user.name), avatar: user.avatar!, edit: {})
                Header(name: .constant(""), avatar: user.avatar!, edit: {})
            }
            .previewWithName(.name(for: Header.self))
            VStack(spacing: 16.0) {
                AboutMe(text: .constant(user.aboutMe!))
                AboutMe(text: .constant(""))
            }
            .previewWithName(.name(for: AboutMe.self))
            EditProfileView.ErrorMessage(text: "The name cannot be empty", isVisible: true)
                .namedPreview()
        }
    }
}
