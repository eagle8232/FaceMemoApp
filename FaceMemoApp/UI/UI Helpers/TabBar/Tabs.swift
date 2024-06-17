//
//  Tabs.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 17.06.24.
//

import SwiftUI

enum Tabs: String, CaseIterable {
    case home
    case settings
    
    var toString: String {
        return self.rawValue
    }
}
