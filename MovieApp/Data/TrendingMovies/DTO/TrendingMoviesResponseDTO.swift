//
//  TrendingMoviesResponseDTO.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

// MARK: - TrendingMoviesResponseDTO
struct TrendingMoviesResponseDTO: Decodable {
    let movieResults: [BasicMovieDTO]

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
    }
}

struct BasicMovieDTO: Decodable {
    let title: String
    let year: String
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID = "imdb_id"
    }
}
