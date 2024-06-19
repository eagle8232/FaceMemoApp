//
//  HTTPClient.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 20.06.24.
//

import SwiftUI

public final class HTTPClient {
    
    private init() {}
    public static let shared = HTTPClient()
    
    private func request<T: Codable>(endPoint: EndPoint, httpMethod: HTTPMethod) async throws -> T? {
        guard let url = URL(string: endPoint.urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = httpMethod.toString
        
        switch httpMethod {
        case .GET:
            break // Do Nothing
        case .POST(let data):
            urlRequest.httpBody = data
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { return nil }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

extension HTTPClient {
    
    public func POST<T: Codable>(endPoint: EndPoint, body: Data) async -> T? {
        do {
            return try await request(endPoint: endPoint, httpMethod: .POST(body))
        } catch {
            print(error)
            return nil
        }
    }
}
