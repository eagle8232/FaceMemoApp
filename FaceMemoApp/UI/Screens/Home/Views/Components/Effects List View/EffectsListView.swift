//
//  EffectsListView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 18.06.24.
//

import SwiftUI

struct EffectsListView: View {
    @ObservedObject var filterService: FilterService
    let rows = [
        GridItem(.flexible(minimum: 20, maximum: 200))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(DeepAREffect.allCases, id: \.self) { effect in
                    Button {
                        filterService.selectedEffect = effect
                    } label: {
                        EffectCellView(deepAREffect: effect, isSelected: filterService.selectedEffect == effect)
                    }
                }
            }
            .padding()
        }
        .frame(height: 90)
    }
}
