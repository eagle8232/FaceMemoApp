//
//  CustomButtonView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

enum ButtonStyle {
    case rounded(String?, Image?) // - Text or Image
    case circled(String?, Image?) // - Text or Image
    case text(String)
}

struct CustomButton: View {
    // - Customization
    var style: ButtonStyle = .circled(nil, nil)
    var font: Font = .system(size: 15, weight: .medium)
    var blurStyle: UIBlurEffect.Style = .light
    var size: CGFloat = 15
    
    // - Functionality
    let handler: () -> Void
    
    var body: some View {
        buttonView
    }
    
    var buttonView: some View {
        ZStack {
            switch style {
            case .rounded(let title, let image):
                roundedButtonView(title, image)
            case .circled(let title, let image):
                circledButtonView(title, image)
            case .text(let title):
                textButtonView(title)
            }
        }
    }
    
    func roundedButtonView(_ title: String?, _ image: Image?) -> some View {
        Button {
            handler()
        } label: {
            VStack {
                if let image {
                    image
                        .resizable()
                        .frame(width: size, height: size)
                }
                
                if let title {
                    Text(title)
                        .font(font)
                }
            }
            .padding(8)
            .padding(.horizontal, 4)
            .background {
                CustomBlurView(style: blurStyle)
                    .clipShape(Capsule())
            }
        }
    }
    
    func circledButtonView(_ title: String?, _ image: Image?) -> some View {
        Button {
            handler()
        } label: {
            VStack {
                if let image {
                    image
                        .resizable()
                        .frame(width: size, height: size)
                }
                
                if let title {
                    Text(title)
                        .font(font)
                }
            }
            .padding(8)
            .background {
                CustomBlurView(style: blurStyle)
                    .clipShape(Circle())
            }
        }
    }
    
    func textButtonView(_ title: String) -> some View {
        Button {
            handler()
        } label: {
            Text(title)
                .font(font)
        }
    }
    
    
}
