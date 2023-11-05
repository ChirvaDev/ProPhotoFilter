//
//  TipsView.swift
//  PRO Photo Filter
//
//  Created by Pro on 26.09.2023.
//

import SwiftUI
import StoreKit

struct TipsView: View {
    
    @State private var isSelected6Months = false
    @State private var isSelected1Year = false
    @State private var isSelected3Months = false
    @State private var isSelected = false
    @State private var selectedProductID: String?
    @State private var selectedText: String = ""
    
    // змінна для слідкування того, чи обраний план Pro
    @Binding var isProPlanSelected: Bool
    @State private var purchaseResult: Bool?
    
    
    var body: some View {
        ZStack{
            Color("AccentColor1").ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                Image("diamond1")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .tint(.indigo)
                
                
                Text("Upgrade to Pro")
                    .font(.custom("Lato-Bold", size: 37) )
                    .foregroundColor(.white)
                Text("You wil be able to make unlimited professional filteres")
                    .font(.custom("Lato-regular", size: 20) )
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                
                
                Text("Choose your plan")
                    .font(.custom("Lato-Bold", size: 32) )
                    .foregroundColor(.white)
                
                Text("Popular")
                    .font(.custom("Lato-regular", size: 20) )
                    .foregroundColor(.white)
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.blue))
                HStack{
                    Text("6\nmonth\n$9.99")
                        .font(.custom("Lato-bold", size: 20) )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray).opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isSelected6Months ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            isSelected6Months .toggle()
                            isSelected1Year = false
                            isSelected3Months = false
                            isSelected.toggle()
                            selectedText = "6 Months"
                            selectedProductID = "com.TestWorkApp.PROPhotoFilter.6MonthsTip"
                            
                        }
                    
                    
                    Text("1\nyear\n$14.99")
                        .font(.custom("Lato-bold", size: 20) )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray).opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isSelected1Year ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            isSelected6Months = false
                            isSelected1Year .toggle()
                            isSelected3Months = false
                            isSelected.toggle()
                            selectedText = "1 Year"
                            selectedProductID = "com.TestWorkApp.PROPhotoFilter.1YearTip"
                            
                        }
                    
                    Text("3\nmonth\n$6.99")
                        .font(.custom("Lato-bold", size: 20) )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.gray).opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isSelected3Months ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            isSelected6Months = false
                            isSelected1Year = false
                            isSelected3Months.toggle()
                            isSelected.toggle()
                            selectedText = "3 Months"
                            selectedProductID = "com.TestWorkApp.PROPhotoFilter.9MonthsTip"
                            
                        }
                    
                }
                .padding(5)
                VStack{
                    Text("Trial period: not avilable")
                        .font(.custom("Lato-regular", size: 20) )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        if isSelected, let productID = selectedProductID {
                            PurchaseManager.shared.purchaseProduct(withIdentifier: productID) { success in
                                // Оновіть результат покупки та інтерфейс
                                purchaseResult = success
                                isProPlanSelected = success // Встановлення значення в `isProPlanSelected`
                            }
                        }
                    }) {
                        Text("Continue")
                            .padding(10)
                            .padding(.horizontal, 70)
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(isSelected ? Color.blue : Color.white))
                            .foregroundColor(isSelected ? Color.white : Color("AccentColor1"))
                        //   .foregroundColor((isSelected6Months && isSelected1Year && isSelected3Months) ? Color.white : Color("AccentColor1"))
                        
                        
                            .font(.custom("Lato-Bold", size: 27))
                    }
                    if let purchaseResult = purchaseResult {
                        Text(purchaseResult ? "Purchase was successful!" : "Purchase failed.")
                            .font(.custom("Lato-Bold", size: 20))
                            .foregroundColor(purchaseResult ? .green : .red)
                        
                    }
                    
                }
                Spacer()
                
            }
            
        }
    }
}

//struct TipsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsView()
//    }
//}
