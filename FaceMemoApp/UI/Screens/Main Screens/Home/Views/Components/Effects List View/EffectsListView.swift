//
//  EffectsListView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

struct EffectsListView: View {
    @Binding var selectedEffect: DeepAREffect
    
    let rows = [
        GridItem(.flexible(minimum: 20, maximum: 200))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(DeepAREffect.allCases, id: \.self) { effect in
                    Button {
                        selectedEffect = effect
                    } label: {
                        EffectCellView(deepAREffect: effect, isSelected: selectedEffect == effect)
                    }
                }
            }
            .padding()
        }
        .frame(height: 90)
    }
}
