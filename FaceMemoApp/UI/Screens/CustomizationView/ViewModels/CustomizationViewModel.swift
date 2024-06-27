//
//  CustomizationViewModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 22.06.24.
//

import SVGKit
import SwiftUI

/**
 - Parameter item: Name of a sticker
 - Parameter svgImage: Image which supports SVG type
 */

class CustomizationViewModel: ObservableObject {
    @Published var stickers: [Sticker] = []
    
    let fileManager: FileManager = FileManager.default
    let path = Bundle.main.bundlePath
    
    init() {
        fetchStickers()
    }
    
    private func fetchStickers() {
        do {
            let items = try fileManager.contentsOfDirectory(atPath: path).map {$0.replacingOccurrences(of: ".svg", with: "")}
            
            for item in items {
                if let url = Bundle.main.url(forResource: item, withExtension: "svg") {
                    let data = try Data(contentsOf: url)
                    
                    /// - After loading SVG Image successfully, we append a new sticker to 'stickers'
                    if let svgImage = SVGKImage(data: data) {
                        print("SVG image loaded successfully")
                        svgImage.size = CGSize(width: Constants.stickerSize, height: Constants.stickerSize)
                        let sticker = Sticker(name: item, image: svgImage.uiImage)
                        
                        DispatchQueue.main.async { [ weak self ] in
                            self?.stickers.append(sticker)
                        }
                    } else {
                        print("Failed to create SVGKImage from data: \(data)")
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
}
