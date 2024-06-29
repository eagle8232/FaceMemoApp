//
//  CustomizationView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 21.06.24.
//

import SwiftUI

struct CustomizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: CustomizationViewModel = CustomizationViewModel()
    
    @Binding var imageToCustomize: UIImage /// - Use UIImage for a customization
    /// - Set a default image by a new captured image, so users can reset customized image
    var defaultImage: UIImage?
    let completion: (UIImage) -> Void /// - ImageModel with customized image
    
    init(customize image: Binding<UIImage>, completion: @escaping (UIImage) -> Void) {
        self._imageToCustomize = image
        self.completion = completion
        
        /// - Set default, so users can reset customized image, if they don't like it
        self.defaultImage = self.imageToCustomize
    }
    
    var body: some View {
        contentView
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    cancelButtonView
                }
            })
            .navigationBarBackButtonHidden()
    }
    
    // MARK: - Views
    
    var contentView: some View {
        ZStack(alignment: .bottomTrailing) {
            customizedImageView
            stickersView
            if !vm.isPresentingStickers {
                actionButtonsView
            }
        }
        
    }
    
    var customizedImageView: some View {
        ZStack {
            ImageCustomizerView(selectedImage: $imageToCustomize, selectedStickers: vm.selectedStickers)
        }
    }
    
    var stickersView: some View {
        ZStack {
            if vm.isPresentingStickers {
                StickersView(stickers: vm.stickers, selectedStickers: $vm.selectedStickers , isPresentingStickers: $vm.isPresentingStickers) {
                    vm.isPresentingStickers = false
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
            /// As we cancel customization of the selected image, we dismiss view
            /// It is safe to force unwrap it, as we already set a value to 'defaultImage'
            imageToCustomize = defaultImage!
            dismiss()
        }
    }
    
    // Save Button
    var saveButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "checkmark")), size: 25) {
            completion(imageToCustomize)
            /// After saving customization of the selected image, we dismiss view
            dismiss()
        }
    }
    
    // Show Stickers Button View
    var showStickersButtonView: some View {
        CustomButton(style: .circled(nil, Image(.sticker)), size: 25) {
            vm.isPresentingStickers = true
        }
        .padding()
    }
}
