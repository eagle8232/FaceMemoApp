//
//  StorageManager.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

class StorageManager: ObservableObject {
    private let fileManager = FileManager.default
    
    private let imagesDataFileName = "encryptedFolderData.json"
    private var imagesDataFileURL: URL {
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(imagesDataFileName)
    }
    
    public func fetchData<T: Codable>(as value: T, completion: @escaping ((Result<T, Error>) -> Void)) {
        do {
            if fileManager.fileExists(atPath: imagesDataFileURL.path()) {
                let encodedData = try Data(contentsOf: imagesDataFileURL)
                let decodedData = try JSONDecoder().decode(T.self, from: encodedData)
                print(decodedData)
                completion(.success(decodedData))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func storeData<T: Codable>(value: T, completion: @escaping ((Error?) -> Void)) {
        do {
            let encodedData = try JSONEncoder().encode(value)
            print(encodedData)
            try encodedData.write(to: imagesDataFileURL)
        } catch {
            completion(error)
        }
    }
}
