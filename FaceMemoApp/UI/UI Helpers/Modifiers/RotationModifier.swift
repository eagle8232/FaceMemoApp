//
//  RotationModifier.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

struct RotationModifier: ViewModifier {
    let completion: (Angle) -> Void
    
    @State var angle: Angle = Angle(degrees: 0)
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle)
            .gesture(gesture)
    }
    
    var gesture: some Gesture {
        RotationGesture()
            .onChanged({ angle in
                self.angle = angle
            })
            .onEnded { angle in
                withAnimation {
                    self.angle = angle
                    completion(angle)
                }
            }
    }
}
