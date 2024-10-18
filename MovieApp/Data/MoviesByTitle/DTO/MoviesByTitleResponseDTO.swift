//
//  MoviesByTitleResponseDTO.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MoviesByTitleResponseDTO
struct MoviesByTitleResponseDTO: Decodable {
    let movieResults: [BasicMovieDTO]

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
    }
}
