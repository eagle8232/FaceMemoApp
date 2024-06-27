//
//  AboutUsView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import SwiftUI

struct AboutUsView: View {
    /// - Tried to write like this for the first time, looking interesting
    let icon     : Image  = Image(systemName: "info.circle")
    let title    : String = "About Us"
    let infoText : String = Constants.aboutUsText
    
    @Binding var isPresentingAboutUs: Bool
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            contentView
            cancelButtonView
            
        }
        .padding()
        .background {
            CustomBlurView(style: .light)
                .clipShape(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                )
        }
        .padding()
    }
    
    var contentView: some View {
        VStack {
            icon
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.vertical, 8)
            
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .padding(.vertical, 8)
            
            Text(infoText)
                .font(.system(size: 15, weight: .regular))
                .padding(.vertical, 8)
        }
        .multilineTextAlignment(.center)
    }
    
    var cancelButtonView: some View {
        // Cancel Button
        CustomButton(style: .circled(nil, Image(systemName: "xmark"))) {
            isPresentingAboutUs = false
        }
        .foregroundStyle(.white)
    }
}
