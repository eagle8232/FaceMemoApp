//
//  JSONConverter.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import Foundation

class JSONConverter {
    
    static func encode<T: Encodable>(value: T) -> Data? {
        do {
            let encodedData = try JSONEncoder().encode(value.self)
            return encodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
