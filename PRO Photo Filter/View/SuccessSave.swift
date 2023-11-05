//
//  SuccessSave.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.10.2023.
//

import SwiftUI

struct SuccessSave: View {
    var body: some View {
        ZStack{
            Color("AccentColor1").ignoresSafeArea()

            VStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.blue)
                    .font(.custom("Lato-regular", size: 50))
                    .padding(5)
                Text("Your photo has been \nsuccessfully saved \nin the gallery!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Lato-Bold", size: 19) )
                    .foregroundColor(Color("AccentColor1"))
            }
            .padding()
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.white)))
            .opacity(0.9)
            
        }
    }
}

struct SuccessSave_Previews: PreviewProvider {
    static var previews: some View {
        SuccessSave()
    }
}
