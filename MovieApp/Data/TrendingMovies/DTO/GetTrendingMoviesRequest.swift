//
//  GetTrendingMoviesRequest.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import Foundation

// MARK: - GetTrendingMoviesRequest
struct GetTrendingMoviesRequest: Request {
    // MARK: ResponseType
    typealias ResponseType = TrendingMoviesResponseDTO
    
    // MARK: Properties
    let method: HTTPMethod = .GET
    let body: BodyType = .empty
    let query: [String: String]
    
    // MARK: Initializer
    init(requestDTO: TrendingMoviesRequestDTO) {
        self.query = ["page": "\(requestDTO.page)"]
    }
}
