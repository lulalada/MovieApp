//
//  TrendingMoviesResponse.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

// MARK: - TrendingMoviesResponse
struct TrendingMoviesResponse {
    let movies: [BasicMovie]
}

// MARK: - BasicMovie
struct BasicMovie {
    let title: String
    let year: String?
    let imdbID: String
}
