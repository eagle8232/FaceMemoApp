//
//  CustomizationView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 21.06.24.
//

import SwiftUI

struct CustomizationView: View {
    let selectedImage: Image
    
    @Binding var showView: Bool
    @State var selectedSticker: Stickers?
    
    var body: some View {
        ZStack {
            actionButtons
        }
    }
    
    /// - Buttons such as cancel and save
    var actionButtons: some View {
        VStack {
            
            HStack(alignment: .center) {
                
                // Cancel Button
                CustomButton(style: .circled(nil, Image(systemName: "xmark")), size: 15) {
                    // As we cancel customization of the selected image, we dismiss view
                    showView = false
                }
                
                Spacer()
                
                // Save Button
                CustomButton(style: .circled(nil, Image(systemName: "checkmark")), size: 15) {
                    
                    // After saving customization of the selected image, we dismiss view
                    showView = false
                }
            }
            Spacer()
        }
    }
}
