//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func request<T: Request>(_ service: T, completion: @escaping (Result<T.ResponseType, NetworkError>) -> Void)
}

// MARK: - NetworkManager
class NetworkManager {
    func request<T: Request>(_ service: T, completion: @escaping (Result<T.ResponseType, NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: service.route)
        urlComponents?.queryItems = service.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        
        service.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        switch service.body {
        case .encodable(let encodable):
            do {
                request.httpBody = try JSONEncoder().encode(encodable)
            } catch {
                completion(.failure(.requestFailed))
                return
            }
        case .empty:
            request.httpBody = nil
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.ResponseType.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
