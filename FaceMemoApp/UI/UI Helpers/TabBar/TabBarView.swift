//
//  TabBarView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: Tabs
    @Namespace var tabAnimation
    
    var body: some View {
        contentView
            .padding(.horizontal, 16) // - No need for vertical, looks big and awful
            .background {
                CustomBlurView(style: .dark)
                    .clipShape(Capsule())
            }
    }
    
    var contentView: some View {
        HStack {
            ForEach(Tabs.allCases, id: \.self) { tab in
                tabView(tab: tab)
            }
        }
    }
    
    func tabView(tab: Tabs) -> some View {
        ZStack {
            Image(currentTab == tab ? "selected\(tab.toString.capitalized)" : tab.toString)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: Constants.iconSize, height: Constants.iconSize)
                .padding(8)
                .background {
                    if currentTab == tab {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(.white)
                            .matchedGeometryEffect(id: "tabBackground", in: tabAnimation)
                    }
                }
        }
        .padding(8)
        .onTapGesture {
            withAnimation() {
                currentTab = tab
            }
        }
    }
}
