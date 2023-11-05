//
//  ImagePicker.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.09.2023.
//

import SwiftUI
import PhotosUI

struct ImagePiker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePiker.Coordinator(parent: self)
    }
    
    @Binding var picker : Bool
    @Binding var imageData: Data
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator : NSObject, PHPickerViewControllerDelegate{
        
        var parent: ImagePiker
        
        init(parent: ImagePiker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            //Cheking image is selected or canceled
            
            if !results.debugDescription.isEmpty{
                
                //cheking image  can be loaded..
                if let firstResult = results.first, firstResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    firstResult.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.imageData = image.pngData() ?? Data()
                                //self.parent.selectedImage = image
                                self.parent.picker.toggle()
                            }
                        } else {
                            // Обробка помилки завантаження зображення
                        }
                    }
                    
                } else {
                    self.parent.picker.toggle()
                }
            }
            
        }
    }
}
