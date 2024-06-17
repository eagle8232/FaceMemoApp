//
//  ContentView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var currentTab: Tabs = .home
    
    var body: some View {
        ZStack {
            switch currentTab {
            case .home:
                HomeView()
            case .recently:
                ZStack {}
            case .settings:
                ZStack {}
            }
            tabBarView
        }
    }
    
    var tabBarView: some View {
        VStack {
            Spacer()
            TabBarView(currentTab: $currentTab)
        }
    }
    
}
