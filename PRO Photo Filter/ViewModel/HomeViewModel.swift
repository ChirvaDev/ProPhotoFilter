//
//  HomeViewModel.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.09.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

// вибір плану
enum Plan {
    case basic
    case pro
}

class HomeViewModel: ObservableObject{
    
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    
    @Published var allImages: [FilteredImage] = []
    
    //main editing image
    @Published var mainView : FilteredImage!
    
    //Slider for intensity
    //Since we didnt set while reading image. So all will be full value
    @Published var value : CGFloat = 1.0
    
    //зміннa, яка вказує, чи має відображатися SuccessSave
    @Published var showSuccessSave = false
    
    // loading FilterOption WhenEver Image is selected...
    @Published var selectedImage: UIImage?
    
    //властивість щоб відстежувати обраний план(по дефолту стоїть basic)
    @Published var selectedPlan: Plan = .basic
    

    @Published var basicFilters: [CIFilter] = [
        CIFilter.sepiaTone(),
        CIFilter.sharpenLuminance(),
        CIFilter.colorBlendMode() ,
        CIFilter.photoEffectTonal(),
        CIFilter.colorClamp(),
        CIFilter.photoEffectInstant()
      ]
    
    
    @Published var proFilters: [CIFilter] = [
          CIFilter.comicEffect(),
          CIFilter.kaleidoscope(),
      ]
    
    
    //функція для зміни обраного плану
    func selectPlan(_ plan: Plan) {
        selectedPlan = plan
    }
    
    
    func loadFilter(){
        
        let context = CIContext()
        let selectedFilters = selectedPlan == .pro ? proFilters : basicFilters
        
        selectedFilters.forEach{
            (filter) in
            
            //To Avoid Lag Do it in background
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                //loading Image Into Filter
                
                let CiImage = CIImage(data: self.imageData)
                
                filter.setValue(CiImage, forKey: kCIInputImageKey)
                
                // retreving image
                
                guard let newImage = filter.outputImage else { return }
                
                //Creatin UIImage
                
                let cgimage = context.createCGImage(newImage, from: newImage.extent)
                
                let isEditable = filter.inputKeys.count > 1
                
                let filtredData = FilteredImage(image: UIImage(cgImage: cgimage!), filter: filter, isEditable: isEditable)
                
                DispatchQueue.main.async {
                    
                    self.allImages.append(filtredData)
                    
                    // defalt is first filter..
                    
                    if self.mainView == nil {self.mainView = self.allImages.first}
                    
                }
            }
            
        }
    }
    
    func updateEffect(){
        
        let context = CIContext()
            let filter = self.mainView.filter

            if filter.inputKeys.contains("inputIntensity") {
                let intensity = selectedPlan == .pro ? 2.0 : 1.0
                filter.setValue(intensity, forKey: kCIInputIntensityKey)
            }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            //loading Image Into Filter
            
            let CiImage = CIImage(data: self.imageData)
            
            filter.setValue(CiImage, forKey: kCIInputImageKey)
            
            // retreving image
            
            if filter.inputKeys.contains("inputIntensity"){
                filter.setValue(self.value, forKey: kCIInputIntensityKey)
            }
            
            guard let newImage = filter.outputImage else { return }
            
            //Creating UIImage
            
            let cgimage = context.createCGImage(newImage, from: newImage.extent)
            
            
            DispatchQueue.main.async {
                
                //updating view ...
                self.mainView.image = UIImage(cgImage: cgimage!)
                
            }
        }
        
    }
    
    func updateIntensity(for image: FilteredImage, with intensity: Double) -> FilteredImage {
        let filter = image.filter
        let isEditable = filter.inputKeys.contains("inputIntensity")

        let context = CIContext()
        guard let ciImage = CIImage(data: image.image.pngData() ?? Data()) else {
            // Опрацювання помилки - немає зображення
            return image
        }

        filter.setValue(ciImage, forKey: kCIInputImageKey)

        if isEditable {
            filter.setValue(intensity, forKey: kCIInputIntensityKey)
        }

        guard let outputImage = filter.outputImage else {
            // Опрацювання помилки - немає вихідного зображення
            return image
        }

        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            // Опрацювання помилки - не вдалося створити CGImage
            return image
        }

        return FilteredImage(image: UIImage(cgImage: cgImage), filter: filter, isEditable: isEditable)
    }

    
    func filteredImage(using filter: CIFilter) -> UIImage {
        let context = CIContext()
        guard let ciImage = CIImage(data: imageData) else {
            return UIImage() // Повертаємо пустий об'єкт, якщо немає даних
        }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        if filter.inputKeys.contains("inputIntensity") {
            filter.setValue(value, forKey: kCIInputIntensityKey)
        }
        
        guard let outputImage = filter.outputImage else {
            return UIImage() // Повертаємо пустий об'єкт, якщо фільтр не має виходу
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return UIImage() // Повертаємо пустий об'єкт, якщо не вдалося створити CGImage
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    
    func loadImage() {
        if let uiImage = UIImage(data: imageData) {
            selectedImage = uiImage
            // Очистити старі фільтри, якщо такі є
            allImages.removeAll()
            mainView = nil
            loadFilter()
        }
    }
    
}
