//
//  DeepARSwiftUIView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import DeepAR

struct DeepARSwiftUIView: UIViewControllerRepresentable {
    @Binding var effect: DeepAREffect
    
    func makeUIViewController(context: Context) -> DeepARViewController {
        let deepARViewController = DeepARViewController(effect: effect)
        return deepARViewController
    }
    
    func updateUIViewController(_ uiViewController: DeepARViewController, context: Context) {
        uiViewController.switchEffect(effect: effect)
    }
}
