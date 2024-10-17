//
//  GetMovieByIDRequest.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

// MARK: - GetMovieByIDRequest
struct GetMovieByIDRequest: Request {
    // MARK: ResponseType
    typealias ResponseType = MovieByIDResponseDTO
    
    // MARK: Properties
    let route: String = Consts.route
    let method: HTTPMethod = .GET
    let body: BodyType = .empty
    let query: [String: String]
    
    // MARK: Initializer
    init(requestDTO: MovieByIDRequestDTO) {
        self.query = ["movieid": "\(requestDTO.movieid)"]
    }
}

// MARK: - Consts
private extension GetMovieByIDRequest {
    enum Consts {
        static let route = "https://movies-tv-shows-database.p.rapidapi.com/"
    }
}
