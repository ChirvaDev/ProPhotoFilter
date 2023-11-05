//
//  HomeView.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.09.2023.
//

import SwiftUI

struct Home: View {
    @State private var isSelectedBasic = true
    @State private var isSelectedPro = false
    @State private var isSelectedFilter = false
    @State private var showProFilters: Bool = false
    @State private var isProPlanSelected = false
    
    @StateObject private var homeData = HomeViewModel()
    
    var body: some View {
        
        ZStack{
            Color("AccentColor1").ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                if !homeData.allImages.isEmpty && homeData.mainView != nil {
                    
                    Spacer(minLength: 0)
                    
                    Image(uiImage: homeData.mainView.image )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                    
                    Slider(value: $homeData.value)
                        .padding()
                        .opacity(homeData.mainView.isEditable ? 1 : 0)
                        .disabled(!homeData.mainView.isEditable)
                    
                        .onChange(of: homeData.value) { newValue in
                            for i in 0..<homeData.allImages.count {
                                let image = homeData.allImages[i]
                                homeData.allImages[i] = homeData.updateIntensity(for: image, with: newValue)
                            }
                        }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack(spacing: 20){
                            if homeData.selectedPlan == .basic {
                                ForEach(homeData.basicFilters.indices, id: \.self) { index in
                                    let filter = homeData.basicFilters[index]
                                    GeometryReader { proxy in
                                        Image(uiImage: homeData.filteredImage(using: filter))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 0)
                                                    .stroke(Color.white, lineWidth: 5)
                                            )
                                            .onTapGesture {
                                                homeData.value = 1.0
                                                let filteredImage = homeData.filteredImage(using: filter)
                                                homeData.mainView = FilteredImage(image: filteredImage, filter: filter, isEditable: filter.inputKeys.contains("inputIntensity"))
                                            }
                                        
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            } else if homeData.selectedPlan == .pro {
                                ForEach(homeData.proFilters.indices, id: \.self) { index in
                                    let filter = homeData.proFilters[index]
                                    GeometryReader { proxy in
                                        Image(uiImage: homeData.filteredImage(using: filter))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 0)
                                                    .stroke(Color.white, lineWidth: 5)
                                            )
                                            .onTapGesture {
                                                homeData.value = 1.0
                                                let filteredImage = homeData.filteredImage(using: filter)
                                                homeData.mainView = FilteredImage(image: filteredImage, filter: filter, isEditable: filter.inputKeys.contains("inputIntensity"))
                                            }
                                        
                                    }
                                    .frame(width: 100, height: 100)
                                }
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                }
                else if homeData.imageData.count == 0 {
                    
                    //Pick An Image To Process!
                    PickImage()
                    Spacer()
                }
                
                else{
                    //Loading View...
                    ProgressView()
                }
                
                if homeData.imageData.count != 0 {
                    
                    HStack {
                        Button(action: {
                            isSelectedBasic = true
                            isSelectedPro = false
                            homeData.selectedPlan = .basic
                            
                        }) {
                            Text("Basic Filters")
                        }
                        .padding(10)
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(isSelectedBasic ? Color.blue : Color.white))
                        .foregroundColor(isSelectedBasic ? Color.white : Color("AccentColor1"))
                        .font(.custom("Lato-Bold", size: 20))
                        .onTapGesture {
                            isSelectedBasic = true
                            isSelectedPro = false
                            homeData.selectedPlan = .basic
                        }
                        
                        Button(action: {
                            if isProPlanSelected {
                                showProFilters.toggle()
                            } else {
                                isSelectedPro = true
                                isSelectedBasic = false
                                // Показати екран підписки при натисканні кнопки "Pro Filters"
                                isProPlanSelected = true
                            }
                        }) {
                            Text("Pro Filters")
                        }
                        .padding(10)
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(isSelectedPro ? Color.blue : Color.white))
                        .foregroundColor(isSelectedPro ? Color.white : Color("AccentColor1"))
                        .font(.custom("Lato-Bold", size: 20))
                        .alert(isPresented: $isProPlanSelected) {
                            Alert(
                                title: Text("Upgrade to Pro"),
                                message: Text("Unlock all Pro filters with a subscription."),
                                primaryButton: .default(Text("Subscribe"), action: {
                                    // Показати екран підписки або взяти підписку через In-App Purchase
                                    TipsView(isProPlanSelected: $isProPlanSelected)
                                    // Після успішної підписки встановити isProPlanSelected в false
                                    isProPlanSelected = false
                                    // Також тут можна встановити isSelectedPro в true, якщо користувач вже має підписку
                                }),
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Button(action: {
                        homeData.showSuccessSave = true
                        UIImageWriteToSavedPhotosAlbum(homeData.mainView.image, nil, nil, nil)
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Export Your Photo")
                        }
                        .padding(10)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white))
                        .foregroundColor(Color("AccentColor1"))
                        .font(.custom("Lato-Bold", size: 23))
                        .disabled(homeData.mainView == nil ? true : false)
                        
                    }
                    .sheet(isPresented: $homeData.showSuccessSave) {
                        SuccessSave()
                    }
                    
                    Spacer()
                    
                }
            }
            
            .sheet(isPresented: $showProFilters) {
                TipsView(isProPlanSelected: $isProPlanSelected)
            }
            
            .onChange(of: homeData.value, perform: { (_) in
                
                homeData.updateEffect()
            })
            
            .onChange(of: homeData.imageData, perform: { (_) in
                // When ever image is changed firing loadImage....
                
                //clearing exisiting data...
                homeData.allImages.removeAll()
                homeData.mainView = nil
                homeData.loadFilter()
            })
            
            .toolbar{
                //Image button 1
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {homeData.imagePicker.toggle()} ){
                        //Text("Gallery")
                        Image(systemName: "photo")
                            .font(.custom("Lato-Regular", size: 20))
                    }
                    .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $homeData.imagePicker){
                ImagePiker(picker: $homeData.imagePicker, imageData: $homeData.imageData)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Home()
    }
}

