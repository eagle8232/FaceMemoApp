//
//  SettingsModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import SwiftUI

enum Settings: String, CaseIterable {
    case aboutUs
    case termsOfUse
    case privacyPolicy
    
}

extension Settings {
    
    var title: String {
        switch self {
        case .aboutUs:
            return "About Us"
        case .termsOfUse:
            return "Terms of Use"
        case .privacyPolicy:
            return "Privacy Policy"
        }
    }
    
    var text: String {
        switch self {
        case .aboutUs:
            return ""
        case .termsOfUse:
            return ""
        case .privacyPolicy:
            return ""
        }
    }
    
    var iconString: String {
        return self.rawValue
    }
    
}
