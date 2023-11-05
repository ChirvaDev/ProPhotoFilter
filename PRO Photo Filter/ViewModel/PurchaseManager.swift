//
//  PurchaseManager.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.10.2023.
//

import StoreKit

class PurchaseManager: NSObject {
    static let shared = PurchaseManager()
    
    // Замикання для відстеження результату покупки.
    var purchaseCompletion: ((Bool) -> Void)?
    
    override private init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func purchaseProduct(withIdentifier productIdentifier: String, completion: @escaping (Bool) -> Void) {
        if SKPaymentQueue.canMakePayments() {
            purchaseCompletion = completion // Збережіть замикання, щоб використовувати його після покупки.
            
            let payment = SKMutablePayment()
            payment.productIdentifier = productIdentifier
            SKPaymentQueue.default().add(payment)
        } else {
            // Handle the case where purchases are not allowed on the device
            completion(false) // Викликайте замикання з результатом покупки (false в цьому випадку).
        }
    }
    
    func getProduct(for productIdentifier: String) -> SKProduct? {
        // This is where you would find the product by its identifier
        // You can check your product collection and find the one that matches productIdentifier
        return nil // Return the found product
    }
}

// Розширення PurchaseManager для реалізації методів SKPaymentTransactionObserver.
extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                // Покупка або відновлення завершено успішно.
                queue.finishTransaction(transaction)
                purchaseCompletion?(true) // Викликайте замикання з результатом покупки (true в цьому випадку).
            case .failed:
                // Помилка покупки.
                queue.finishTransaction(transaction)
                purchaseCompletion?(false) // Викликайте замикання з результатом покупки (false в цьому випадку).
            default:
                break
            }
        }
    }
}


