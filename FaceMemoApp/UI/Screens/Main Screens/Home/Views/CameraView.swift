//
//  CameraView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CameraView: View {
    @StateObject var cameraManager = CameraManager()
    @Binding var selectedEffect: DeepAREffect
    @Binding var capturedImage: UIImage?
    
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
        CustomButton(style: .circled(nil, Image(.camera)), blurStyle: .dark, size: 40) {
            cameraManager.takePicture()
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
            if marketingImageString != nil, let url = URL(string: marketingImageString ?? "") {
                WebImage(url: url)
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
