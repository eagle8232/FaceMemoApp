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
    @Binding var isPresentingStickers: Bool
    let didSelect: () -> Void
    
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
            let visibleSize = Constants.stickerSize * 3
            
            VStack {
                Spacer()
                
                contentView(height: height, visibleSize: visibleSize)
                    .offset(y: height - visibleSize)
                    .offset(y: -offset > 0 ? (-offset <= (height - visibleSize) ? offset : -(height - visibleSize)) : 0)
                    .gesture(
                        DragGesture()
                            .updating($gestureOffset) { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }
                            .onEnded({ value in
                                let maxHeight = height - visibleSize
                                
                                withAnimation {
                                    if -offset > visibleSize && offset < maxHeight {
                                        offset = -(maxHeight / 2.5)
                                    } else if -offset > maxHeight / 2 {
                                        offset = -maxHeight
                                    } else {
                                        offset = 0
                                    }
                                    
                                    lastOffset = offset
                                }
                            })
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func contentView(height: CGFloat, visibleSize: CGFloat) -> some View {
        ZStack(alignment: .topTrailing) {
            CustomBlurView(style: .dark)
                .ignoresSafeArea()
            
            VStack {
                Capsule()
                    .frame(width: 80, height: 4)
                    .padding(16)
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(stickers, id: \.name) { sticker in
                            Image(uiImage: sticker.image)
                                .onTapGesture {
                                    selectedStickers.append(sticker)
                                    didSelect()
                                }
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.bottom, height - visibleSize - (-offset))
            }
            
            dismissButtonView
                .padding(8)
        }
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: Constants.cornerRadius))
    }
    
    var dismissButtonView: some View {
        CustomButton(style: .circled(nil, Image(systemName: "xmark")), size: 12) {
            isPresentingStickers = false
        }
    }
    
    func onChange() {
            DispatchQueue.main.async {
                withAnimation {
                self.offset = gestureOffset + lastOffset
            }
        }
    }
}
