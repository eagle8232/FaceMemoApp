//
//  Constants.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

class Constants {
    // MARK: - All String Values
    
    // About Us Text
    static let aboutUsText: String = """
    FaceMemo is a fun and innovative app that transforms your photo-taking experience by adding exciting face effects. Capture unforgettable moments with a wide range of creative filters that bring your pictures to life. FaceMemo also allows you to add personalized descriptions to each photo, helping you cherish and remember the stories behind every snapshot
"""
    static let termsOfUseURL: URL? = URL(string: "https://facememo.wordpress.com/terms-of-use/")
    
    static let privacyPolicyURL: URL? = URL(string: "https://facememo.wordpress.com/privacy-policy/")
    
    // Marketing Name
    /// - Use it to get marketing data from API
    static let marketingName: String = "CameraEffect"
    
    // DeepAR License Key
    /// - Use license key to use DeepAR's filters
    static let deepARLicenseKey: String = "7d247769fbca297905489d214fa8d2460654598df54bacaaf92ca44528667f8988ac4f63e8746551"
    
    // MARK: - All CG Values
    
    static let cornerRadius: CGFloat = 15
    static let iconSize: CGFloat = 35
    static let bottomPaddingSize: CGFloat = 20
    static let stickerSize: CGFloat = 70
    // Defaults
    static let defaultLocation: CGPoint = CGPoint(x: 300, y: 600)
    static let defaultAngle: Angle = Angle(degrees: 0)
    static let defaultScale: CGFloat = 1.0
    static let defaultSize: CGSize = CGSize(width: 200, height: 200)
}
