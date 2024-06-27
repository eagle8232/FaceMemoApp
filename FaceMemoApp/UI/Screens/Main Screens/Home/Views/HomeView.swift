//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var storageVM: StorageViewModel
    @State var showCustomizationView: Bool = false
    
    var body: some View {
        contentView
            .background {
                NavigationLink(isActive: $showCustomizationView) {
                    CustomizationView(customizedImage: $storageVM.capturedImage) { imageModel in
                        guard let imageModel else { return }
                        storageVM.imageModels.append(imageModel)
                        storageVM.saveImages()
                    }
                } label: {}
            }
    }
    
    var contentView: some View {
        ZStack {
            CameraView(selectedEffect: $storageVM.selectedEffect, capturedImage: $storageVM.capturedImage)
            
            if let capturedImage = storageVM.capturedImage {
                CustomAlertView(
                    title: "Captured Photo",
                    message: "Do you want to save this photo to your album?",
                    alertType: .saveImage,
                    image: Image(uiImage: capturedImage)) {
                        
                        /// After dismissing alert view, we need to set nil to capturedImage
                        storageVM.capturedImage = nil
                        
                    } submit: { // Submit Handler
                        
                        let imageModel = ImageModel(name: "Image with '\(storageVM.selectedEffect.name)' effect", imageData: capturedImage.jpegData(compressionQuality: 1) ?? Data(), date: Date())
                        storageVM.imageModels.append(imageModel)
                        storageVM.saveImages()
                        
                        /// After saving the photo, we need to set nil to capturedImage
                        storageVM.capturedImage = nil
                        
                    } customize: {
                        showCustomizationView = true
                    }
            }
        }
    }
}

