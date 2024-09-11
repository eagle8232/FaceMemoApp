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
    
   
}
