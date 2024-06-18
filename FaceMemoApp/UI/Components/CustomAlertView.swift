//
//  CustomAlertView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    var image: Image? /// - If saves the image, it will show it
    
    var isSubmitVisible: Bool
    var isShareVisible: Bool = false /// - Non visible by default
    
    let dismiss: () -> Void
    var submit: (() -> Void)?
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    if isShareVisible {
                        /// - We make force unwrapping, as we already set value to 'image' to share it
                        ShareLink(item: image!, preview: SharePreview("Filtered Image", image: image!)) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .padding(.leading)
                    }
                }
                
                Divider()
                
                Text(message)
                    .font(.callout)
            }
            
            if let image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
            }
            
            buttonsView
        }
        .padding()
        .background {
            CustomBlurView(style: .light)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        }
        .padding()
    }
    
    var buttonsView: some View {
        HStack {
            // Cancel Button
            CustomButton(style: .rounded("Cancel", nil)) {
                dismiss()
            }
            .foregroundStyle(.white)
            
            // Submit Button (If needed)
            if isSubmitVisible {
                CustomButton(style: .rounded("Submit", nil), blurStyle: .extraLight) {
                    submit?()
                }
                .foregroundStyle(.gray)
            }
        }
    }
    
}
