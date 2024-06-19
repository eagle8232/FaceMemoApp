//
//  EndPoint.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

public enum EndPoint: EndPointProtocol {
    case marketingAds
    case marketingSplashAds
    case marketingVideos
    
    var urlString: String {
        switch self {
        case .marketingAds:
            return "\(baseURLString)marketing-ads"
        case .marketingSplashAds:
            return "\(baseURLString)marketing-splash-ads"
        case .marketingVideos:
            return "\(baseURLString)marketing-videos"
        }
    }
}
