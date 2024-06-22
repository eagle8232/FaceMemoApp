//
//  Sticker.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 22.06.24.
//

import SwiftUI

struct Sticker: Identifiable {
    let id: String = UUID().uuidString
    let name: String /// - We won't show name of a sticker, but we want to use it in views
    let image: Image
}