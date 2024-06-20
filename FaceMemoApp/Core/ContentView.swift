//
//  ContentView.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var marketingRepository = MarketingRepository()
    @State var currentTab: Tabs = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            // Changed from switch method to TabView
            //,/ - We use TabView method, to ensure all views are not updated again
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(Tabs.home)
                
                RecentlyView()
                    .tag(Tabs.recently)
                
                SettingsView()
                    .tag(Tabs.settings)
            }
            
            tabBarView
        }
    }
    
    var tabBarView: some View {
        VStack {
            Spacer()
            TabBarView(currentTab: $currentTab)
        }
        .padding(.bottom, Constants.bottomPaddingSize)
    }
    
}
