//
//  DeepARSwiftUIView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct DeepARSwiftUIView: UIViewControllerRepresentable, CameraManagerDelegate {
    @ObservedObject var cameraManager: CameraManager
    @Binding var effect: DeepAREffect
    var completion: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> DeepARViewController {
        let viewController = DeepARViewController(cameraManager: cameraManager, effect: effect)
        cameraManager.delegate = self
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DeepARViewController, context: Context) {
        uiViewController.switchEffect(effect: effect)
    }
    
    // MARK: - Camera Manager Delegate
    
    func didTakePhoto(_ image: UIImage!) {
        completion(image)
    }
}
