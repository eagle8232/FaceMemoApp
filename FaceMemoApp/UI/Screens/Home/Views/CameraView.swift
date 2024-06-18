//
//  CameraView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

struct CameraView: View {
    @StateObject var cameraManager = CameraManager()
    @State var selectedEffect: DeepAREffect = DeepAREffect.allCases.first!
    @State var capturedImage: UIImage?
    @State var showShareLink: Bool = false
    var body: some View {
        ZStack {
            contentView
            VStack {
                effectsView
                Spacer()
                captureButton
            }
            .padding(.bottom, 50)
            
            if let capturedImage {
                CustomAlertView(title: "Captured Photo", message: "Do you want to save this photo to your album?", image: Image(uiImage:capturedImage), isSubmitVisible: true, isShareVisible: true) {
                    /// After dismissing alert view, we need to set nil to capturedImage
                    self.capturedImage = nil
                } submit: { // Submit Handler
                    UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
                    /// After saving the phott, we need to set nil to capturedImage
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
       }
       
}

#Preview {
    CameraView()
}
