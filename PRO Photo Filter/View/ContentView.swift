//
//  ContentView.swift
//  PRO Photo Filter
//
//  Created by Pro on 15.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
                .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
