//
//  ImageCellView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

struct ImageCellView: View {
    let imageModel: ImageModel
    let imageSize: CGFloat = 170
    
    let isEditing: Bool
    let isSelected: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            // Selection View
            if isEditing {
                ZStack {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                }
            }
            
            Image(uiImage: UIImage(data: imageModel.imageData)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            VStack(alignment: .leading) {
                Text(imageModel.name)
                    .font(.system(size: 16, weight: .bold))
                Text(imageModel.description ?? "No Description Here")
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(.gray.opacity(0.4))
                    }
                Spacer()
                Text(imageModel.date.formatted())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background {
            CustomBlurView(style: .dark)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        }
    }
    
}
