//
//  GetMoviesByTitleRequest.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Foundation

// MARK: - GetMoviesByTitleRequest
struct GetMoviesByTitleRequest: Request {
    // MARK: ResponseType
    typealias ResponseType = MoviesByTitleResponseDTO
    
    // MARK: Properties
    let method: HTTPMethod = .GET
    let body: BodyType = .empty
    let query: [String: String]
    
    // MARK: Initializer
    init(requestDTO: MoviesByTitleRequestDTO) {
        self.query = ["title": "\(requestDTO.title)"]
    }
    
    func additionalHeaders() -> [String: String] {
        return ["Type": "get-movies-by-title"]
    }
}
