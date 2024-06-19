//
//  Model.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

struct APIResponse: Codable {
    
    let data: [DataResponse]?
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([DataResponse].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.data, forKey: .data)
    }
}

struct DataResponse: Codable {
    let url: String
    let fileLink: String
    
    enum CodingKeys: CodingKey {
        case url
        case fileLink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.fileLink = try container.decode(String.self, forKey: .fileLink)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.fileLink, forKey: .fileLink)
    }
}

