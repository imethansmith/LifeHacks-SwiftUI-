//
//  LoginView.swift
//  LifeHacks
//
//  Created by Ethan Smith on 1/10/21.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) private var presentationMode
    @AppStorage(LifehacksApp.Keys.isLoggedIn) private var isLoggedIn = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Lifehacks")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button(action: logIn) {
                Text("Log In")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 242, height: 82)
                    .background(LinearGradient.blue)
                    .cornerRadius(41.0)
            }
            HStack(spacing: 8.0) {
                Text("Logging in...")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                ProgressView()
            }
        }
    }
}

private extension LoginView {
    func logIn() {
        isLoggedIn = true
        presentationMode.wrappedValue.dismiss()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
