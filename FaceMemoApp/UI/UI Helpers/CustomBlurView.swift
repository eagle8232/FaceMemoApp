//
//  CustomBlurView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct CustomBlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .light
    
    func makeUIView(context: Context) -> some UIView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
