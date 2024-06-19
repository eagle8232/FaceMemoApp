//
//  HomeViewModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

class HomeViewModel: ObservableObject, StorageDelegate {
    
    @Published var images: [ImageModel] = []
    
    init() {
        fetchImages()
    }
    
    private let storageManager: StorageManager = StorageManager()
    
    public func fetchImages() {
        storageManager.fetchData(as: images) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let images):
                DispatchQueue.main.async {
                    self.images = images
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func saveImages() {
        /// - Store to FileManager
        storageManager.storeData(value: images) { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
        
        /// - Store to photo album
        guard let lastSavedImageModel = images.last,
              let capturedPhoto = UIImage(data: lastSavedImageModel.imageData) 
        else { return }
        
        UIImageWriteToSavedPhotosAlbum(capturedPhoto, nil, nil, nil)
    }
    
}
