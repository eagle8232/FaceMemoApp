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
    static let deepARLicenseKey: String = "7e7cc541b882d34c55773cfafbbfe884a66700f50ad34b5830342f72575b2b868cad631eb0d84044"
    
    // MARK: - All CGFloaf Values
    
    static let cornerRadius: CGFloat = 15
    static let iconSize: CGFloat = 35
    static let bottomPaddingSize: CGFloat = 32
    static let stickerSize: CGFloat = 70
}
