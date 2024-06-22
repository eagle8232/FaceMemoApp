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
    let selectedImage: UIImage /// - Use UIImage for a customization
    
    @State var selectedStickers: [Sticker] = []
    
    var body: some View {
        contentView
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    cancelButtonView
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButtonView
                }
                
            })
            .navigationBarBackButtonHidden()
    }
    
    // MARK: - Views
    
    var contentView: some View {
        ZStack {
            customizedImageView
            actionButtons
            stickersView
        }
    }
    
    var customizedImageView: some View {
        ZStack {}
    }
    
    var stickersView: some View {
        StickersView(stickers: customizationVM.stickers, selectedStickers: $selectedStickers)
            .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // MARK: - Buttons
    
    // Cancel Button
    var cancelButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "xmark")), size: 15) {
            // As we cancel customization of the selected image, we dismiss view
            dismiss()
        }
    }
    
    // Save Button
    var saveButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "checkmark")), size: 15) {
            
            // After saving customization of the selected image, we dismiss view
            dismiss()
        }
    }
    
    var actionButtons: some View {
        VStack {
            HStack(alignment: .center) {
                
                
                Spacer()
                
                
            }
            Spacer()
        }
    }
}
