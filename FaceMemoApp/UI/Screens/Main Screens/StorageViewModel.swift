//
//  StorageViewModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

class StorageViewModel: ObservableObject {
    
    @Published var imageModels: [ImageModel] = []
    
    private let storageManager: StorageManager = StorageManager()
    
    init() {
        fetchImages()
    }
    
    // - Public Functions
    public func fetchImages() {
        storageManager.fetchData(as: imageModels) { [ weak self ] result in
            guard let self else { return }
            switch result {
            case .success(let imageModels):
                DispatchQueue.main.async {
                    self.imageModels = imageModels
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func saveImages() {
        /// - Store to photo album
        guard let lastSavedImageData = imageModels.last?.imageData,
              let capturedPhoto = UIImage(data: lastSavedImageData)
        else { return }
        saveData()
        UIImageWriteToSavedPhotosAlbum(capturedPhoto, nil, nil, nil)
    }
    
    public func deleteImageModelAt(_ imageModel: ImageModel) {
        guard let index = imageModels.firstIndex(where: {$0.id == imageModel.id}) else { return }
        imageModels.remove(at: index)
        saveData()
    }
    
    public func deleteSelectedImageModels(_ imageModels: [ImageModel]) {
        for imageModel in imageModels {
            self.imageModels.removeAll(where: {$0.id == imageModel.id})
        }
        saveData()
    }
    
    public func saveDescription(for imageModel: ImageModel, text: String) {
        guard let index = imageModels.firstIndex(where: {imageModel.id == $0.id}) else { return }
        imageModels[index].description = text
        saveData()
    }
    
    // - Private Functions
    
    private func saveData() {
        storageManager.storeData(value: imageModels) { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
}
