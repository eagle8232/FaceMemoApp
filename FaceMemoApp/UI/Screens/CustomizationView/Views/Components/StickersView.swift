//
//  StickersView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 22.06.24.
//

import SwiftUI

struct StickersView: View {
    let stickers: [Sticker]
    @Binding var selectedStickers: [Sticker]
    
    // Stickers View Properties
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { proxy in
            
            let height = proxy.size.height
            
            contentView
                .offset(y: height - Constants.stickerSize * 2)
                .offset(y: -offset > 0 ? (-offset <= (height - 100) ? offset : -(height - 100)) : 0)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset) { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }
                        .onEnded({ value in
                            let maxHeight = height - 100
                            
                            withAnimation {
                                // Drag Logic
                                
                                //  Drag to Mid
                                if -offset > 100 && offset < maxHeight / 2 {
                                    offset = -(maxHeight / 3)
                                } else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                } else {
                                    offset = 0
                                }
                                
                                /// Storing last offset, so gesture can continue from last position
                                lastOffset = offset
                            }
                        })
                )
        }
    }
    
    var contentView: some View {
        ZStack {
            CustomBlurView(style: .dark)
                .ignoresSafeArea()
            
            VStack {
                Capsule()
                    .frame(width: 80, height: 4)
                    .padding(16)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        /// - We can use ForEach loop without 'id: \.name' because Sticker Model is Identifiable, but we want to see stickers by their names
                        ForEach(stickers, id: \.name) { sticker in
                            sticker.image
                                .onTapGesture {
                                    selectedStickers.append(sticker)
                                }
                        }
                    }
                }
            }
        }
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: Constants.cornerRadius))
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}

