//
//  ImageModel.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

struct ImageModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let imageData: Data
    var description: String?
    let date: Date
}
