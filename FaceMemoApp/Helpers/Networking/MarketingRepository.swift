//
//  MarketingRepository.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

class MarketingRepository: ObservableObject {
    
    let body: [String: [String]] = [
        "marketingNames": [Constants.marketingName]
    ]
    
    private let http: HTTPClient = .shared
    
    // MARK: - Public Functions
    
    @MainActor
    public func getSplashAds(completion: @escaping (DataResponse?) -> Void) async {
        let marketingData = await getMarketingData(endPoint: .marketingSplashAds)
        
        if let data = marketingData?.data,
           !data.isEmpty {
            completion(data[0])
        }
    }
    
    @MainActor
    public func getBannerAds(completion: @escaping (DataResponse?) -> Void) async {
        let marketingData = await getMarketingData(endPoint: .marketingAds)
        
        if let data = marketingData?.data,
           !data.isEmpty {
            completion(data[0])
        }
    }
    
    @MainActor
    public func getVideoAds(completion: @escaping (DataResponse?) -> Void) async {
        let marketingData = await getMarketingData(endPoint: .marketingVideos)
        
        if let data = marketingData?.data,
           !data.isEmpty {
            completion(data[0])
        }
    }
    
    
    
    // MARK: - Private Functions
    
    private func getMarketingData(endPoint: EndPoint) async -> APIResponse? {
        guard let encodedBody = JSONConverter.encode(value: body) else { return nil }
        return await http.POST(endPoint: endPoint, body: encodedBody)
    }
    
}
