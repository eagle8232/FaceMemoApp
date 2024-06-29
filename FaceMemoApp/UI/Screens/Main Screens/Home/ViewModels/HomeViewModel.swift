//
//  HomeViewModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 29.06.24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedEffect: DeepAREffect = DeepAREffect.allCases.first!
    @Published var showCustomizationView: Bool = false
    
    /// - Parameters:
    ///  - capturedImage: A new captured photo by a user
    ///  - selectedImage: An image, which is set after a user captures a new photo and is used for customization of the photo
    @Published var capturedImage: UIImage?
    @Published var selectedImage: UIImage
    
    init(selectedImage: UIImage? = nil) {
        self.selectedImage = selectedImage ?? UIImage(resource: .sticker)
    }
    
}
