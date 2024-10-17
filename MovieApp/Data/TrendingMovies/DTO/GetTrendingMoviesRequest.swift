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
    let route: String = Consts.route
    let method: HTTPMethod = .GET
    let body: BodyType = .empty
    let query: [String: String]
    
    // MARK: Initializer
    init(requestDTO: TrendingMoviesRequestDTO) {
        self.query = ["page": "\(requestDTO.page)"]
    }
}

// MARK: - Consts
private extension GetTrendingMoviesRequest {
    enum Consts {
        static let route = "https://movies-tv-shows-database.p.rapidapi.com/"
    }
}
