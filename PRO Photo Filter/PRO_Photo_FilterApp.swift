//
//  PRO_Photo_FilterApp.swift
//  PRO Photo Filter
//
//  Created by Pro on 15.09.2023.
//

import SwiftUI

@main
struct PRO_Photo_FilterApp: App {
    
    // Властивість для перевірки першого запуску
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
        
    var body: some Scene {
        WindowGroup {
            // Відображення IntroScreen, якщо це перший запуск
            if hasLaunchedBefore {
                NavigationView {
                    Home()
                        .preferredColorScheme(.dark)

                }
            } else {
                NavigationView {
                    IntroScreen()
                }
            }
        }
    }
}



