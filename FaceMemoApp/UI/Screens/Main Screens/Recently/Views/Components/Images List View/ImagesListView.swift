//
//  ImagesListView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

struct ImagesListView: View {
    @Binding var isEditing: Bool
    @Binding var selectedImageModels: [ImageModel]
    
    let imageModels: [ImageModel]
    let columns = [
        GridItem(.flexible())
    ]
    
    let descriptionToCreate: (ImageModel) -> Void
    let deleteImageModel: (ImageModel) -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(imageModels, id: \.date) { imageModel in
                    cellView(imageModel: imageModel)
                }
            }
            .padding(10)
            .padding(.bottom, Constants.bottomPaddingSize + 80)
        }
    }
    
    func cellView(imageModel: ImageModel) -> some View {
        
        ImageCellView(
            imageModel: imageModel,
            isEditing: isEditing,
            isSelected: selectedImageModels.contains(where: {imageModel.id == $0.id})
        )
            .contextMenu (
                ContextMenu(menuItems: {
                    Button(role: .destructive) {
                        deleteImageModel(imageModel)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                })
            )
            .onTapGesture {
                selectImageModel(imageModel: imageModel)
            }
    }
    
    func selectImageModel(imageModel: ImageModel) {
        withAnimation {
            if isEditing {
                if !selectedImageModels.contains(where: {imageModel.id == $0.id}) {
                    selectedImageModels.append(imageModel)
                } else {
                    selectedImageModels.removeAll(where: {imageModel.id == $0.id})
                }
            } else if !isEditing {
                descriptionToCreate(imageModel)
            }
        }
    }
}
