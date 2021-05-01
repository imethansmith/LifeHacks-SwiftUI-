//
//  RoundImage.swift
//  LifeHacks
//
//  Created by Ethan Smith on 1/05/21.
//

import SwiftUI

struct RoundImage: View {
    let image: UIImage
    var borderColor: Color = .white
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: 2))
    }
}

struct RoundImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundImage(image: TestData.user.avatar)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
