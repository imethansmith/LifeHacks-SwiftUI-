//
//  ImagePicker.swift
//  LifeHacks
//
//  Created by Ethan Smith on 24/09/21.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    let source: UIImagePickerController.SourceType
    @Binding var image: UIImage
    
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(imagePicker: self)
    }
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = source
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let imagePicker: ImagePicker
        
        init(imagePicker: ImagePicker) {
            self.imagePicker = imagePicker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePicker.dismiss()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            defer { imagePicker.dismiss() }
            guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else { return }
            imagePicker.image = image
        }
    }
}
