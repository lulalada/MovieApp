//
//  MoviesByTitleDTOToDomainMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MoviesByTitleDTOToDomainMapper
final class MoviesByTitleDTOToDomainMapper {
    func mapModel(_ model: MoviesByTitleResponseDTO) -> MoviesByTitleResponse {
        MoviesByTitleResponse(movies: model.movieResults.map {
            BasicMovie(
                title: $0.title,
                year: $0.year,
                imdbID: $0.imdbID
            )
        })
    }
}
