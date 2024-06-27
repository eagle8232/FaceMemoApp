//
//  DraggableView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 23.06.24.
//

import SwiftUI

struct DraggableView: ViewModifier {
    let completion: (CGPoint) -> Void
    
    @State private var isDragging: Bool = false
    @State private var location: CGPoint = CGPoint(x: 190, y: 300) // Default Position
    
    func body(content: Content) -> some View {
        content
            .position(location)
            .gesture(dragGesture)
    }
    
    // MARK: - Gesture
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
                self.isDragging = true
            }
            .onEnded { _ in
                self.isDragging = false
                completion(location)
            }
    }
}
