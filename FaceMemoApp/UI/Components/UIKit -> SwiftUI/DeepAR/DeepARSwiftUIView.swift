//
//  DeepARSwiftUIView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct DeepARSwiftUIView: UIViewControllerRepresentable {
    @ObservedObject var cameraManager: CameraManager
    @Binding var effect: DeepAREffect
    
    func makeUIViewController(context: Context) -> DeepARViewController {
        let viewController = DeepARViewController(cameraManager: cameraManager, effect: effect)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DeepARViewController, context: Context) {
        uiViewController.switchEffect(effect: effect)
    }
}
