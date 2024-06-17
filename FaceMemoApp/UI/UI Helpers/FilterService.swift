//
//  FilterService.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import StreamVideo
import DeepAR
import CoreImage

@MainActor
class FilterService: NSObject, ObservableObject {
    
    @Published var filtersActive: Bool = false
    @Published var selectedEffect: DeepAREffect = DeepAREffect.allCases.first!
    
    private var deepAR: DeepAR!
    var deepARFilter: VideoFilter!
    
    var currentProcessedImage: CIImage?
    
    override init() {
        super.init()
        
        /// - Initiliaze DeepAR as in the docs, refer to: https://docs.deepar.ai/deepar-sdk/platforms/ios/getting-started/
        self.deepAR = DeepAR()
        self.deepAR.setLicenseKey(Constants.deepARLicenseKey)
        self.deepAR.delegate = self
        self.deepAR.changeLiveMode(false)
        
        /// - Create the filter for DeepAR and add it to supported filters
        deepARFilter = createDeepARFilter(deepAR: self.deepAR)
    }
    
    func createDeepARFilter(deepAR: DeepAR) -> VideoFilter {
        let deepARVideoFilter = VideoFilter(id: "deep", name: "DeepAR") { [weak self] image in
            guard let self else { return CIImage() }
            let rotatedImage = image.originalImage.oriented(.right)
            if self.deepAR.renderingInitialized == false {
                self.deepAR.initializeOffscreen(
                    withWidth: Int(rotatedImage.extent.width),
                    height: Int(rotatedImage.extent.height)
                )
                
                guard let path = self.selectedEffect.path else { return rotatedImage }
                self.deepAR.switchEffect(withSlot: "effect", path: path)
            }
            let pixelBuffer: CVPixelBuffer = rotatedImage.toCVPixelBuffer()
            self.deepAR.processFrame(pixelBuffer, mirror: true)
            
            return self.currentProcessedImage ?? rotatedImage
        }
        return deepARVideoFilter
    }
    
    func filterSelected(effect: DeepAREffect) {
        guard let path = effect.path else {
            print("Couldn't find the path to the selected effect: \(effect.rawValue)")
            return
        }
        self.deepAR.switchEffect(withSlot: "effect", path: path)
    }
}

extension FilterService: DeepARDelegate {
    func faceTracked(_ faceData: MultiFaceData) {
        
    }
    
    func faceVisiblityDidChange(_ faceVisible: Bool) {
        
    }
    
    func didFinishShutdown() {
        print("Did finish shut down called ")
    }
    
    func didInitialize() {
        print("didInitialize")
    }
    
    func frameAvailable(_ sampleBuffer: CMSampleBuffer!) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("[DeepAR] *** NO BUFFER ERROR")
            return
        }
        let image = CIImage(cvPixelBuffer: pixelBuffer)
        let mirror = image.transformed(by: CGAffineTransform(-1, 0, 0, 1, image.extent.width, 0))
        self.currentProcessedImage = mirror.oriented(.left )
    }
}
