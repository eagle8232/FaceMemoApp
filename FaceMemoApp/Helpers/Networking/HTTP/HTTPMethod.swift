//
//  HTTPMethod.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

public enum HTTPMethod {
    case GET
    case POST(Data)
    
    var toString: String {
        switch self {
        case .GET:
            return "GET"
        case .POST(_):
            return "POST"
        }
    }
}
