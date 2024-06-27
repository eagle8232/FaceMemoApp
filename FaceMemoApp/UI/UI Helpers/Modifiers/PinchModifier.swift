//
//  PinchModifier.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

struct PinchModifier: ViewModifier {
    let completion: (CGFloat) -> Void
    
    @State var scale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(1 + scale + lastScale)
            .gesture(gesture)
    }
    
    var gesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                scale = value - 1
            }
            .onEnded { value in
                lastScale += scale
                scale = 0
                completion(1 + lastScale)
            }
    }
}
