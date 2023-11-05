////
////  TipsStore.swift
////  PRO Photo Filter
////
////  Created by Pro on 27.09.2023.
////
//
//import SwiftUI
//import StoreKit
//
//enum TipsError: Error {
//    case failedVerification
//    case system(Error)
//}
//
//enum TipsAction: Equatable {
//    static func == (lhs: TipsAction, rhs: TipsAction) -> Bool {
//        <#code#>
//    }
//    
//    case successful
//    case failed(TipsError)
//}
//
//@MainActor
//class TipsStore: ObservableObject {
//    @Published private(set) var items = [Product]()
//    @Published private(set) var action: TipsAction?
//    @Published var hasError = false
//
//    var error: TipsError? {
//        switch action {
//        case .failed(let err):
//            return err
//        default:
//            return nil
//        }
//    }
//
//    init() {
//        Task {
//            await retrieveProducts()
//        }
//    }
//
//    func reset() {
//        action = nil
//    }
//    
//    func purchase(productID: String) async {
//        if let product = items.first(where: { $0.productIdentifier == productID }) {
//            do {
//                let result = try await product.purchase()
//                try await handlePurchase(from: result)
//            } catch {
//                action = .failed(.system(error))
//                print(error)
//            }
//        }
//    }
//
//    private func retrieveProducts() async {
//        do {
//            let productIDs = [
//                "com.TestWorkApp.PROPhotoFilter.6MonthsTip",
//                "com.TestWorkApp.PROPhotoFilter.1YearTip",
//                "com.TestWorkApp.PROPhotoFilter.9MonthsTip"
//            ]
//            let products = try await Product.products(for: productIDs)
//            items = products.sorted(by: { $0.price < $1.price })
//        } catch {
//            action = .failed(.system(error))
//            print(error)
//        }
//    }
//
//    private func handlePurchase(from result: PurchaseResult) async throws {
//        // Реалізуйте обробку покупки тут
//        switch result {
//        case .success(let verification):
//            print("Purchase was a success, now it's time to verify their purchase")
//            // Реалізуйте верифікацію покупки тут
//            action = .successful
//        case .pending:
//            print("The user needs to complete some action on their account before they can complete the purchase")
//        case .userCancelled:
//            print("The user hit cancel before their transaction started")
//        default:
//            print("Unknown error")
//        }
//    }
//}
