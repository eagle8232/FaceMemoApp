//
//  CameraManager.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import DeepAR

protocol CameraManagerDelegate {
    func didTakePhoto(_ image: UIImage!)
}

class CameraManager: NSObject, ObservableObject, DeepARDelegate {
    var deepAR: DeepAR?
    var completion: ((UIImage) -> Void)?
    
    var delegate: CameraManagerDelegate?
    
    func takePicture() {
        if let deepAR {
            deepAR.delegate = self
            deepAR.takeScreenshot()
        }
    }
    
    func didTakeScreenshot(_ screenshot: UIImage!) {
        delegate?.didTakePhoto(screenshot)
    }
    
}
