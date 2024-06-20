//
//  SettingsVie.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsView: View {
    @StateObject var settingsVM: SettingsViewModel = SettingsViewModel()
    @State var currentSelectedParameter: Settings = .aboutUs
    @State var isPresentingAboutUs: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Settings")
                        .font(.system(size: 25, weight: .bold))
                        .padding()
                    bannerView
                }
                contentView
            }
            
            if isPresentingAboutUs {
                AboutUsView(isPresentingAboutUs: $isPresentingAboutUs)
            }
        }
        
    }
    
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [.init(.flexible())]) {
                ForEach(Settings.allCases, id: \.self) { parameter in
                    settingsCellView(title: parameter.title, iconString: parameter.iconString) {
                        openSafari(parameter: parameter)
                    }
                }
            }
        }
    }
    
    func settingsCellView(title: String, iconString: String, completion: @escaping () -> Void) -> some View {
        Button {
            completion()
        } label: {
            HStack {
                HStack {
                    Image(iconString)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(title)
                        .font(.system(size: 17, weight: .regular))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.white)
            .padding()
            .background {
                CustomBlurView(style: .light)
                    .clipShape(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    )
            }
            .padding(8)
        }
    }
    
    // MARK: - Marketing Banner Ads View
    var marketingRepository: MarketingRepository = MarketingRepository()
    
    @State var marketingImageString: String?
    @State var marketingUrlString: String?
    
    var bannerView: some View {
        ZStack {
            if marketingImageString != "" {
                WebImage(url: URL(string: marketingImageString ?? ""))
                    .resizable()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        if let urlString = marketingUrlString, let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }
            }
        }
        .onAppear {
            Task {
                await marketingRepository.getBannerAds { data in
                    marketingImageString = data?.fileLink
                    marketingUrlString = data?.url
                }
            }
        }
    }
    
    
    
    func openSafari(parameter: Settings) {
        var url: URL?
        switch parameter {
        case .aboutUs:
            isPresentingAboutUs = true
        case .termsOfUse:
            url = Constants.termsOfUseURL
        case .privacyPolicy:
            url = Constants.privacyPolicyURL
        }
        
        if let url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
