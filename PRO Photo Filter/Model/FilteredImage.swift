//
//  FilteredImage.swift
//  PRO Photo Filter
//
//  Created by Pro on 16.09.2023.
//

import CoreImage
import SwiftUI

struct FilteredImage: Identifiable {
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var isEditable: Bool
}
