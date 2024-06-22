//
//  CustomAlertView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

enum CustomAlertType {
    case saveDescription
    case saveImage
    case none
}

struct CustomAlertView: View {
    let title: String
    let message: String
    let alertType: CustomAlertType
    
    // Alert Values
    @State var descriptionText: String = ""
    @State var isEditing: Bool = false
    var image: Image? /// - If saves the image, it will show it
    
    let dismiss: () -> Void
    var submit: (() -> Void)?
    var submitText: ((String) -> Void)?
    var customize: (() -> Void)?
    
    var body: some View {
        ZStack {
            contentView
        }
    }
    
    // MARK: - Content View
    
    var contentView: some View {
        VStack {
            // Title & Message Views
            VStack {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    if alertType == .saveImage {
                        Spacer()
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
            
            // Saving Data View
            switch alertType {
                
            case .saveDescription:
                VStack(alignment: .trailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                    
                    CustomTextField(text: $descriptionText, isEditing: $isEditing)
                        .background {
                            CustomBlurView(style: .dark)
                                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        }
                        .frame(height: 200)
                }
            case .saveImage:
                if let image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                }
            case .none:
                ZStack {} /// - Show nothing
            }
            
            // Action Buttons
            buttonsView
        }
        .padding()
        .background {
            CustomBlurView(style: .light)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        }
        .padding()
    }
    
    // MARK: - Buttons View
    
    var buttonsView: some View {
        HStack(spacing: 8) {
            cancelButtonView
            if alertType == .saveImage {
                customizeButtonView
            }
            if alertType != .none {
                submitButtonView
            }
        }
    }
    
    var cancelButtonView: some View {
        // Cancel Button
        CustomButton(style: .rounded("Cancel", nil)) {
            dismiss()
        }
        .foregroundStyle(.white)
    }
    
    var submitButtonView: some View {
        // Submit Button (If needed)
        CustomButton(style: .rounded("Submit", nil), blurStyle: .dark) {
            if alertType == .saveDescription {
                submitText?(descriptionText)
            } else {
                submit?()
            }
        }
        .foregroundStyle(.green)
    }
    
    var customizeButtonView: some View {
        // Customize Button (If needed)
        CustomButton(style: .rounded("Customize", nil), blurStyle: .dark) {
            customize?()
        }
        .foregroundStyle(LinearGradient(colors: [.purple, .cyan, .mint], startPoint: .leading, endPoint: .trailing))
    }
}
