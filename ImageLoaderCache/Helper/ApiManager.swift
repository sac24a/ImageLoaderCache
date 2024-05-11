//
//  ApiManager.swift
//  ImageLoaderCache
//
//  Created by Sachin Kanojia on 11/05/24.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    func fetchImages() async throws -> Data {
        let url = URL(string: ApiUrls.fetchImages)!
        do {
            let data = try await callApi(url: url, httpMethod: .get)
            return data
        } catch let error {
            switch error {
            case NetworkError.invalidResponse(let title, let message):
                throw NetworkError.invalidResponse(title,message)
            default:
                throw NetworkError.invalidResponse("Some Error","Invalid response")
            }
        }
    }
    
    private func callApi(url: URL, httpMethod: HTTPMethod) async throws -> Data {
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let errorData = try JSONDecoder().decode(ApiError.self, from: data)
            throw NetworkError.invalidResponse(errorData.message, errorData.data ?? "")
        }
        return data
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case invalidResponse(String, String)
}

struct ApiUrls  {
    static let fetchImages = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
} 
