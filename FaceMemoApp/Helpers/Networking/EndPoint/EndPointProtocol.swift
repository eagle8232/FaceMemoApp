//
//  EndPointProtocol.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

protocol EndPointProtocol {
    var urlString: String { get }
    var baseURLString: String { get }
}

extension EndPointProtocol {
    var baseURLString: String {
        return "https://api.easygetapp.com/api/market/public/"
    }
}
