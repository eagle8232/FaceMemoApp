//
//  ImageCustomizerView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

struct CustomizedValues: Equatable {
    var location: CGPoint = Constants.defaultLocation
    var angle: Angle = Constants.defaultAngle
    var scaleSize: CGFloat = Constants.defaultScale
}

struct ImageCustomizerView: View {
    @Binding var selectedImage: UIImage
    @Binding var selectedStickers: [Sticker]
    
    /// - Drag, rotate and scale properties
    @State var customizedValues: CustomizedValues = CustomizedValues()
    
    var body: some View {
        contentView
    }
    
    // MARK: Views
    
    var contentView: some View {
        ZStack {
            
            Image(uiImage: selectedImage)
                .resizable()
            
            
            ForEach(0..<selectedStickers.count, id: \.self) { id in
                Image(uiImage: selectedStickers[id].image)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear  // We need a view to attach the GeometryReader
                                .onAppear {
                                    let imageSize = geometry.size
                                    print("------ DEBUG: imageSize ------ \n\(imageSize)")
                                    // You can store the imageSize in your model if needed
                                    selectedStickers[id].imageSize = imageSize
                                }
                        }
                    )
                    .draggableView { location in
                        selectedStickers[id].position = location
                        print("------ DEBUG: location ------ \n\(location)")
                    }
                    .pinchView { scaleSize in
                        selectedStickers[id].scale = scaleSize
                        print("------ DEBUG: scaleSize ------ \n\(scaleSize)")
                    }

            }
        }
        
    }
}
