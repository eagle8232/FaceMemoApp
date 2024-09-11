//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var storageVM: StorageViewModel
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    var body: some View {
        contentView
            .background {
                NavigationLink(isActive: $homeVM.showCustomizationView) {
                    CustomizationView(customize: $homeVM.selectedImage) { customizedImage in
                        /// - Update capturedImage by new customized image
                        homeVM.capturedImage = customizedImage
                        
                    }
                } label: {}
            }
    }
    
    var contentView: some View {
        ZStack {
            CameraView(selectedEffect: $homeVM.selectedEffect, capturedImage: $homeVM.capturedImage)
            
            if let capturedImage = homeVM.capturedImage {
                VStack {
                    bannerView
                    CustomAlertView(
                        title: "Captured Photo",
                        message: "Do you want to save this photo to your album?",
                        alertType: .saveImage,
                        image: Image(uiImage: capturedImage)) {
                            
                            /// After dismissing alert view, we need to set nil to capturedImage
                            homeVM.capturedImage = nil
                            
                        } submit: { // Submit Handler
                            
                            let imageModel = ImageModel(name: "Image with '\(homeVM.selectedEffect.name)' effect", imageData: capturedImage.jpegData(compressionQuality: 1) ?? Data(), date: Date())
                            storageVM.imageModels.append(imageModel)
                            storageVM.saveImages()
                            
                            /// After saving the photo, we need to set nil to capturedImage
                            homeVM.capturedImage = nil
                            
                        } customize: {
                            homeVM.showCustomizationView = true
                            homeVM.selectedImage = capturedImage
                        }
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Marketing Banner Ads View
    var marketingRepository: MarketingRepository = MarketingRepository()
    
    @State var marketingImageString: String?
    @State var marketingUrlString: String?
    
    var bannerView: some View {
        ZStack {
            if marketingImageString != nil, let url = URL(string: marketingImageString ?? "") {
                WebImage(url: url)
                    .resizable()
                    .frame(height: 170)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onTapGesture {
                        if let urlString = marketingUrlString, let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }
            }
        }
        .onAppear {
            Task {
                await marketingRepository.getBannerAds { data in
                    marketingImageString = data?.fileLink
                    marketingUrlString = data?.url
                }
            }
        }
    }
}

