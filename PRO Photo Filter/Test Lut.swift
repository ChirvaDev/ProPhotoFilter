//
//  Test Lut.swift
//  PRO Photo Filter
//
//  Created by Pro on 19.09.2023.
//

import SwiftUI

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct Test_Lut: View {
    @State private var inputImage: UIImage?
    @State private var outputImage: UIImage?
    
    let context = CIContext()
    let lutFilter = CIFilter(name: "CIColorCubeWithColorSpace")
    
    var body: some View {
        NavigationView {
            VStack {
                if let outputImage = outputImage {
                    Image(uiImage: outputImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("LaunchScreenIcon1")
                        .resizable()
                        .scaledToFit()
                }
                
                Button("Select an Image") {
                    // Code to select an image from the photo library
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                
                Button("Apply LUT Filter") {
                    applyLUTFilter()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationBarTitle("Photo Filter")
        }
    }
    
    func applyLUTFilter() {
        guard let inputImage = inputImage else { return }
        
        // Convert UIImage to CIImage
        guard let ciImage = CIImage(image: inputImage) else { return }
        
        // Set the input image for the LUT filter
        lutFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Load the LUT from the XMP file
        if let lutURL = Bundle.main.url(forResource: "Lut_1", withExtension: "xmp") {
            if let lutData = try? Data(contentsOf: lutURL) {
                lutFilter?.setValue(lutData, forKey: "inputCubeData")
            }
        }
        
        // Get the output image from the filter
        if let outputCIImage = lutFilter?.outputImage {
            // Render the output CIImage to a CGImage
            if let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
                // Convert CGImage to UIImage
                outputImage = UIImage(cgImage: cgImage)
            }
        }
    }
}




struct Test_Lut_Previews: PreviewProvider {
    static var previews: some View {
        Test_Lut()
    }
}
