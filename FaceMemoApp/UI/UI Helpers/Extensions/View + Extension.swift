//
//  View + Extension.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

extension View {
    func rotateView(completion: @escaping (Angle) -> Void) -> some View {
        self.modifier(RotationModifier { completion($0) })
    }
    
    func pinchView(completion: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(PinchModifier { completion($0) })
    }
    
    func draggableView(completion: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(DraggableView { completion($0) })
    }
}
