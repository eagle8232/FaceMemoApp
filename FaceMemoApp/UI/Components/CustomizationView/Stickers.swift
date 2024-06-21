//
//  Stickers.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 21.06.24.
//

import SwiftUI

enum Stickers: String {
    case smile
    
    var name: String {
        return self.rawValue
    }
    
    var path: String? {
        return Bundle.main.path(forResource: self.rawValue, ofType: "")
    }
}
