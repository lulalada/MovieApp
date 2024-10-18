//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import Foundation
import Combine

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func request<T: Request>(_ service: T) -> AnyPublisher<T.ResponseType, NetworkError>
}

// MARK: - NetworkManager
class NetworkManager: NetworkManagerProtocol {
    func request<T: Request>(_ service: T) -> AnyPublisher<T.ResponseType, NetworkError> {
        var urlComponents = URLComponents(string: service.route)
        urlComponents?.queryItems = service.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents?.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        request.allHTTPHeaderFields = service.headers
        
        return Future<T.ResponseType, NetworkError> { promise in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(.requestFailed))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                      let data = data else {
                    promise(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.ResponseType.self, from: data)
                    promise(.success(decodedData))
                } catch {
                    promise(.failure(.decodingError))
                }
            }.resume()
        }
        .eraseToAnyPublisher()
    }
}
// MARK: - Private
private extension NetworkManager {
    func buildQueryParamsString(using queryParams: [String: CustomStringConvertible]) -> String {
        queryParams.map { $0.key + "=" + $0.value.description }.joined(separator: "&")
    }
}
