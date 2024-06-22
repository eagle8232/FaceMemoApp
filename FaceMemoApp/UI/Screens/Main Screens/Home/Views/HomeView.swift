//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    @State var showCustomizationView: Bool = false
    
    var body: some View {
        
        CameraView { imageModel in
            guard let imageModel else { return }
            homeVM.images.append(imageModel)
            homeVM.saveImages()
        } customizeImage: { uiImage in
            homeVM.selectedImage = uiImage
            showCustomizationView = true
        }
        
        .background {
            NavigationLink(isActive: $showCustomizationView) {
                if let selectedImage = homeVM.selectedImage {
                    CustomizationView(selectedImage: selectedImage)
                }
            } label: {}
        }
    }
    
}

