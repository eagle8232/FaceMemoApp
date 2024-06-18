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
    
    var body: some View {
        ZStack {
            contentView
            VStack {
                effectsView
                Spacer()
                captureButton
            }
            .padding(.bottom, 50)
        }
    }
    
    var contentView: some View {
        DeepARSwiftUIView(cameraManager: cameraManager, effect: $selectedEffect)
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
