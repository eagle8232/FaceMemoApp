//
//  Stickers.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 21.06.24.
//

import SwiftUI

/**
 - Parameter name: The name of the sticker
 - Parameter path: The path to already downloaded sticker
 */


enum Stickers: String {
    case smile
    
    var name: String {
        return self.rawValue
    }
    
    var path: String? {
        return Bundle.main.path(forResource: self.rawValue, ofType: "")
    }
}
