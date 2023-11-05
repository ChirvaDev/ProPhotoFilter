//
//  CustomSlider.swift
//  PRO Photo Filter
//
//  Created by Pro on 20.10.2023.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 8)
                    .foregroundColor(Color.gray.opacity(0.5))

                Capsule()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 8)
                    .foregroundColor(.white)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            let width = geometry.size.width
                            let percent = value.location.x / width
                            self.value = Double(percent)
                        })
                    )
            }
        }
    }
}
//struct CustomSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSlider(value: 1.01)
//    }
//}
