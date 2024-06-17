//
//  HomeView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import StreamVideoSwiftUI
import StreamVideo

struct HomeView: View {
    @StateObject var filterService = FilterService()
    
    var body: some View {
        ZStack {
            contentView
            VStack {
                effectsView
                Spacer()
            }
            .padding(.bottom, 50)
        }
    }
    
    var contentView: some View {
        DeepARSwiftUIView(effect: $filterService.selectedEffect)
            .ignoresSafeArea()
    }
    
    var effectsView: some View {
        EffectsListView(filterService: filterService)
    }
}

#Preview {
    HomeView()
}
