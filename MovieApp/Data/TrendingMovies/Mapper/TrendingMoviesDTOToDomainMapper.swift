//
//  TrendingMoviesDTOToDomainMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - TrendingMoviesDTOToDomainMapper
final class TrendingMoviesDTOToDomainMapper {
    func mapModel(_ model: TrendingMoviesResponseDTO) -> TrendingMoviesResponse {
        TrendingMoviesResponse(movies: model.movieResults.map {
            BasicMovie(
                title: $0.title,
                year: $0.year,
                imdbID: $0.imdbID
            )
        })
    }
}
