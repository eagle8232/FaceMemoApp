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
    @Published var selectedStickers: [Sticker] = []
    @Published var isPresentingStickers: Bool = false
    @Published private var defaultImage: UIImage? /// - Use this to set defaultImage to 'customizedImage' if needed
    
    let fileManager: FileManager = FileManager.default
    let path = Bundle.main.bundlePath
    
    init() {
        fetchStickers()
    }
    
    // MARK: - Public Functions
    @MainActor
    public func renderCustomizedImage(selectedImage: Binding<UIImage>) -> UIImage? {
        let image = selectedImage.wrappedValue
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let combinedImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: image.size))
            
            for sticker in selectedStickers {
                print(sticker.scale)
                print("------ DEBUG: sticker.position ------ \n\(sticker.position)")
                print("------ DEBUG: sticker.scale ------ \n\(sticker.scale)")
                print("------ DEBUG: sticker.width ------ \n\(sticker.image.size.width)")
                print("------ DEBUG: sticker.scale * width ------ \n\(sticker.image.size.width * sticker.scale * 3)")
                let resizedPosition = CGPoint(x: sticker.position.x * 2, y: sticker.position.y * 2.8)
                print(resizedPosition)
                let stickerSize = CGSize(width: sticker.image.size.width * sticker.scale * 3, height: sticker.image.size.height * sticker.scale * 3)
                
                let stickerRect = CGRect(origin: resizedPosition, size: stickerSize)
                
//                if let newStickerImage = resizeImage(image: sticker.image, targetSize: stickerSize) {
                sticker.image.draw(in: stickerRect)
//                }
            }
        }
        
        return combinedImage
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let newImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return newImage
    }
    
    // MARK: - Private Functions
    
    private func fetchStickers() {
        do {
            let items = try fileManager.contentsOfDirectory(atPath: path).map { $0.replacingOccurrences(of: ".svg", with: "") }
            
            for item in items {
                if let url = Bundle.main.url(forResource: item, withExtension: "svg") {
                    let data = try Data(contentsOf: url)
                    
                    /// - After loading SVG Image successfully, we append a new sticker to 'stickers'
                    if let svgImage = SVGKImage(data: data) {
                        print("SVG image loaded successfully")
                        svgImage.size = CGSize(width: Constants.stickerSize, height: Constants.stickerSize)
                        let sticker = Sticker(name: item, image: svgImage.uiImage)
                        
                        DispatchQueue.main.async { [weak self] in
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
