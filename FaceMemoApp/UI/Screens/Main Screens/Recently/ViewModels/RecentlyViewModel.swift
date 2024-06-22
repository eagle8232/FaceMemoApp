//
//  RecentlyViewModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

class RecentlyViewModel: ObservableObject {
    
    @Published var imageModels: [ImageModel] = []
    
    private let storageManager: StorageManager = StorageManager()
    
    // - Public Functions
    
    public func fetchImages() {
        storageManager.fetchData(as: imageModels) { result in
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
