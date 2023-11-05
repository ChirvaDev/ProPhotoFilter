//
//  ExportView.swift
//  PRO Photo Filter
//
//  Created by Pro on 21.09.2023.
//

import SwiftUI

struct ExportView: View {
    
    //@EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        ZStack{
            Color("AccentColor1").ignoresSafeArea()
            
            VStack{
                
                Text("Export your photo")
                    .foregroundColor(.white)
                    .font(.custom("Lato-Bold", size: 30) )
                
                Text("You can download all that apply in your filter")
                    .foregroundColor(.white)
                    .font(.custom("Lato-regular", size: 15) )
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
                
//                Image(uiImage: homeData.selectedImage ?? UIImage())
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: UIScreen.main.bounds.width)
                
                
//                Image(uiImage: homeData.mainView.image) // Отримуємо фільтроване фото з параметру
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 300)
                
                
//                                Button(action: {
//                                    UIImageWriteToSavedPhotosAlbum(homeData.mainView.image), nil, nil, nil)
//                                }){
//                                    HStack {
//                                        Image(systemName: "square.and.arrow.up")
//                                        Text("Export Your Photo")
//                                    }
//                                    .padding(10)
//                                    .padding(.horizontal, 20)
//                                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white))
//                                    .foregroundColor(Color("AccentColor1"))
//                                    .font(.custom("Lato-Bold", size: 23))
//                                }
            }
        }
    }
}

struct ExportView_Previews: PreviewProvider {
    static var previews: some View {
        ExportView()
        
    }
}
