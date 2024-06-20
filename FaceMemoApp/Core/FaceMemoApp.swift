//
//  FaceMemoAppApp.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

@main
struct FaceMemoApp: App {
    var marketingRepository: MarketingRepository = MarketingRepository()
    
    @State var splashImageURLString: String?
    @State var splashUrlString: String?
    @State var showSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if showSplash && splashImageURLString != nil {
                    marketingAdsView
                }
            }
            .onAppear {
                Task {
                    await marketingRepository.getSplashAds { data in
                        splashImageURLString = data?.fileLink
                        splashUrlString = data?.url
                        showSplash = true
                    }
                }
            }
        }
    }
    
    
    // MARK: - Marketing Ads
    
    var marketingAdsView: some View {
        VStack(alignment: .trailing) {
            CustomButton(style: .circled(nil, Image(systemName: "xmark"))) {
                showSplash = false
            }
            
            WebImage(url: URL(string: splashImageURLString ?? ""))
                .resizable()
                .cornerRadius(10)
                .padding()
                .onTapGesture {
                    if let urlString = splashUrlString, let url = URL(string: urlString) {
                        UIApplication.shared.open(url)
                    }
                }
        }
    }
    
}
