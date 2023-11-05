//
//  LaunchScreenView.swift
//  PRO Photo Filter
//
//  Created by Pro on 15.09.2023.
//

import SwiftUI

struct IntroScreen: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("AccentColor1").ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Image("LaunchScreenIcon1")
                            .resizable()
                            .frame(height: 400)
                            .opacity(0.4)
                            .cornerRadius(30)
                        
                        Text("Pro Photo Filter")
                            .font(.custom("Lato-Bold", size: 37) )
                            .foregroundColor(.white)
                        
                    } .ignoresSafeArea()
                    
                    HStack{
                        Image(systemName: "camera.filters")
                            .foregroundColor(.white)
                            .font(.custom("Lato-Bold", size: 25))
                            .padding(10)
                        VStack(alignment: .leading){
                            Text("Many Colorfull Filtres")
                                .font(.custom("Lato-Bold", size: 21) )
                                .foregroundColor(.white)
                            Text("Edit your photos with our \nfree Filtres")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                        .frame(width: 250, height: 70, alignment: .leading)
                    }
                    
                    HStack{
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .font(.custom("Lato-Bold", size: 25))
                            .padding(10)
                        VStack(alignment: .leading){
                            Text("Individual Settings")
                                .font(.custom("Lato-Bold", size: 21) )
                                .foregroundColor(.white)
                            Text("Customize your Filtres with ease")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                        .frame(width: 250, height: 70, alignment: .leading)
                    }
                    
                    HStack{
                        Image(systemName: "wand.and.stars")
                            .foregroundColor(.white)
                            .font(.custom("Lato-Bold", size: 25))
                            .padding(10)
                        VStack(alignment: .leading){
                            Text("New Filtres Weekly")
                                .font(.custom("Lato-Bold", size: 21) )
                                .foregroundColor(.white)
                            Text("Get new Filtres for your pictures \nevery week")
                                .font(.custom("Lato-Regular", size: 16))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                        .frame(width: 250, height: 70, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: Home().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("Choose Your Photo")
                        }
                        .padding(10)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white))
                        .foregroundColor(Color("AccentColor1"))
                        .font(.custom("Lato-Bold", size: 23))
                        .navigationBarBackButtonHidden(true)
                    }
                    
                }
            }
        }
    }
}


struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen()
    }
}

