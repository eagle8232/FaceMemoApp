//
//  CameraView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CameraView: View {
    @ObservedObject var cameraManager = CameraManager()
    @State var selectedEffect: DeepAREffect = DeepAREffect.allCases.first!
    @State var capturedImage: UIImage?
    @State var showShareLink: Bool = false
    
    var saveToAlbum: (ImageModel?) -> Void
    
    var body: some View {
        ZStack {
            contentView
            VStack {
                VStack {
                    effectsView
                    bannerView
                }
                Spacer()
                captureButton
            }
            
            if let capturedImage {
                CustomAlertView(
                    title: "Captured Photo",
                    message: "Do you want to save this photo to your album?",
                    alertType: .saveImage,
                    image: Image(uiImage: capturedImage)) {
                        
                        /// After dismissing alert view, we need to set nil to capturedImage
                        self.capturedImage = nil
                        
                    } submit: { // Submit Handler
                        let imageModel = ImageModel(name: "Image with '\(selectedEffect.name)' effect", imageData: capturedImage.jpegData(compressionQuality: 1) ?? Data(), date: Date())
                        saveToAlbum(imageModel)
                        
                        /// After saving the photo, we need to set nil to capturedImage
                        self.capturedImage = nil
                    }
            }
        }
    }
    
    var contentView: some View {
        DeepARSwiftUIView(cameraManager: cameraManager, effect: $selectedEffect) { image in
            self.capturedImage = image
        }
        .ignoresSafeArea()
    }
    
    var effectsView: some View {
        EffectsListView(selectedEffect: $selectedEffect)
    }
    
    var captureButton: some View {
        Button(action: {
            cameraManager.takePicture()
        }) {
            ZStack {
                Image(uiImage: .camera)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
                    .background {
                        Circle()
                            .fill(Color.white)
                    }
            }
        }
        .padding()
        .padding(.bottom, Constants.bottomPaddingSize + 80) /// - Adding 16 more, as we already added padding to tab bar
    }
    
    // MARK: - Marketing Banner Ads View
    var marketingRepository: MarketingRepository = MarketingRepository()
    
    @State var marketingImageString: String?
    @State var marketingUrlString: String?
    
    var bannerView: some View {
        ZStack {
            if marketingImageString != "" {
                WebImage(url: URL(string: marketingImageString ?? ""))
                    .resizable()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
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
