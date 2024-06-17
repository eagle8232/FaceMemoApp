//
//  FilterCellView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

struct EffectCellView: View {
    let deepAREffect: DeepAREffect
    let isSelected: Bool
    
    @Namespace var blurAnimation
    var body: some View {
        ZStack {
            Text(deepAREffect.name)
                .font(.caption)
                .foregroundStyle(isSelected ? .black.opacity(0.8) : .white)
                .padding(16)
                .background {
                    CustomBlurView(style: isSelected ? .extraLight : .dark)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                }
        }
    }
    
}
