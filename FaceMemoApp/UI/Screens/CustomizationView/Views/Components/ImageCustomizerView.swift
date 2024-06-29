//
//  ImageCustomizerView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

struct ImageCustomizerView: View {
    @Binding var selectedImage: UIImage
    var selectedStickers: [Sticker]
    
    /// - Drag, rotate and scale properties
    @State var location: CGPoint = CGPoint(x: 190, y: 600)
    @State var angle: Angle = Angle(degrees: 0)
    @State var scaleSize: CGFloat = 1
    
    var body: some View {
        contentView
    }
    
    // MARK: Views
    
    var contentView: some View {
        ZStack {
            
            Image(uiImage: selectedImage)
                .resizable()
            
            
            ForEach(selectedStickers) { sticker in
                Image(uiImage: sticker.image)
                    .draggableView { location in
                        self.location = location
                    }
                    .pinchView { scaleSize in
                        self.scaleSize = scaleSize
                    }
                    .onAppear {
                        imageByCombiningImage(firstImage: selectedImage, withImage: sticker.image, at: location, scale: scaleSize, angle: angle)
                    }
                    .onChange(of: location) { newValue in
                        imageByCombiningImage(firstImage: selectedImage, withImage: sticker.image, at: location, scale: scaleSize, angle: angle)
                    }
                    .onChange(of: scaleSize) { newValue in
                        imageByCombiningImage(firstImage: selectedImage, withImage: sticker.image, at: location, scale: scaleSize, angle: angle)
                    }
            }
        }
        
    }
    
    func imageByCombiningImage(firstImage: UIImage, withImage secondImage: UIImage, at location: CGPoint, scale: CGFloat, angle: Angle) {
        let renderer = UIGraphicsImageRenderer(size: firstImage.size)
        let area = CGRect(x: 0, y: 0, width: firstImage.size.width, height: firstImage.size.height)
        
        let image = renderer.image { context in
            firstImage.draw(in: area)
            secondImage.draw(in: area, blendMode: .normal, alpha: 1)
        }
        
        selectedImage = image
    }
}

