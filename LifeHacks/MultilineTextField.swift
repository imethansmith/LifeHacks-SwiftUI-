//
//  MultilineTextField.swift
//  LifeHacks
//
//  Created by Ethan Smith on 17/09/21.
//

import SwiftUI

//MARK: - MultilineTextField
struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(textView: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0.0
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}

extension MultilineTextField {
    class Coordinator: NSObject, UITextViewDelegate {
        let textView: MultilineTextField
        
        init(textView: MultilineTextField) {
            self.textView = textView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.textView.text = textView.text
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(text: .constant(TestData.user.aboutMe))
            .namedPreview()
            .frame(height: 250.0)
    }
}
