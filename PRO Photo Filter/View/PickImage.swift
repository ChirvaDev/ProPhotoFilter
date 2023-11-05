//
//  PickImage.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.10.2023.
//

import SwiftUI

struct PickImage: View {
    var body: some View {
        VStack{
            Image("Arrow")
                .resizable()
                .frame(width: 200, height: 250)
                .rotationEffect(Angle(degrees: 0))
                .opacity(0.6)
                .padding()
            Text("Pick An Image To Process!")
                .foregroundColor(.white)
                .font(.custom("Lato-Bold", size: 23))
        }
    }
}

struct PickImage_Previews: PreviewProvider {
    static var previews: some View {
        PickImage()
    }
}
