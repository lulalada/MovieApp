//
//  GetMovieImageRequest.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - GetMovieImageRequest
struct GetMovieImageRequest: Request {
    // MARK: ResponseType
    typealias ResponseType = MovieImageResponseDTO
    
    // MARK: Properties
    let method: HTTPMethod = .GET
    let body: BodyType = .empty
    let query: [String: String]
    
    // MARK: Initializer
    init(requestDTO: MovieImageRequestDTO) {
        self.query = ["movieid": "\(requestDTO.movieid)"]
    }
    
    func additionalHeaders() -> [String: String] {
        ["Type": "get-movies-images-by-imdb"]
    }
}
