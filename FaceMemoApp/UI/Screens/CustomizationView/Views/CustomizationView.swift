//
//  CustomizationView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 21.06.24.
//

import SwiftUI

struct CustomizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var customizationVM: CustomizationViewModel = CustomizationViewModel()
    
    @Binding var customizedImage: UIImage? /// - Use UIImage for a customization
    let completion: (ImageModel?) -> Void /// - ImageModel with customized 'customizedImage'
    
    @State var isPresentingStickers: Bool = false
    @State var selectedStickers: [Sticker] = []
    @State private var defaultImage: UIImage? /// - Use this to set defaultImage to 'customizedImage' if needed
    
    var body: some View {
        contentView
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    cancelButtonView
                }
            })
            .onAppear {
                self.defaultImage = customizedImage /// - We set a default image with 'customizedImage', as we know that customizedImage is a new captured image
            }
            .navigationBarBackButtonHidden()
    }
    
    // MARK: - Views
    
    var contentView: some View {
        ZStack(alignment: .bottomTrailing) {
            customizedImageView
            stickersView
            if !isPresentingStickers {
                actionButtonsView
            }
        }
        
    }
    
    var customizedImageView: some View {
        ZStack {
            ImageCustomizerView(selectedImage: $customizedImage, selectedStickers: selectedStickers)
        }
    }
    
    var stickersView: some View {
        ZStack {
            if isPresentingStickers {
                StickersView(stickers: customizationVM.stickers, selectedStickers: $selectedStickers , isPresentingStickers: $isPresentingStickers) {
                    isPresentingStickers = false
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
    
    // MARK: - Buttons
    
    var actionButtonsView: some View {
        VStack {
            saveButtonView
            showStickersButtonView
        }
    }
    
    // Cancel Button
    var cancelButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "xmark")), size: 15) {
            // As we cancel customization of the selected image, we dismiss view
            self.customizedImage = defaultImage
            dismiss()
        }
    }
    
    // Save Button
    var saveButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "checkmark")), size: 25) {
            // After saving customization of the selected image, we dismiss view
            dismiss()
        }
    }
    
    // Show Stickers Button View
    var showStickersButtonView: some View {
        CustomButton(style: .circled(nil, Image(.sticker)), size: 25) {
            isPresentingStickers = true
        }
        .padding()
    }
}
