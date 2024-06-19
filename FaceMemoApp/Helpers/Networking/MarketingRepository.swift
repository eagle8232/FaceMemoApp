//
//  MarketingRepository.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

enum MarketingType: String {
    case ads
    case splashAds
    case videos
}

class MarketingRepository: ObservableObject {
    
    @Published var splashImageString: String?
    @Published var splashUrlString: String?
    @Published var showSplash: Bool = true

    let body: [String: [String]] = [
        "marketingNames": [Constants.marketingName]
    ]
    
    private let http: HTTPClient = .shared
    
    func getMarketingData(type: MarketingType) async -> DataResponse? {
        guard let encodedBody = JSONConverter.encode(value: body) else { return nil }
        switch type {
        case .ads:
            return await http.POST(endPoint: .marketingAds, body: encodedBody)
        case .splashAds:
            return await http.POST(endPoint: .marketingSplashAds, body: encodedBody)
        case .videos:
            return await http.POST(endPoint: .marketingVideos, body: encodedBody)
        }
    }
    
}
