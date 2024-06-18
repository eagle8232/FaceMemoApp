//
//  CameraManager.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI
import DeepAR
import AVFoundation

class CameraManager: NSObject, ObservableObject, DeepARDelegate {
    var deepAR: DeepAR?
    
    func takePicture() {
        if let deepAR {
            deepAR.delegate = self
            deepAR.takeScreenshot()
        }
    }
    
    func didTakeScreenshot(_ screenshot: UIImage!) {
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
}
