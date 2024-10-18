//
//  MoviesByTitleDTOToDomainMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MoviesByTitleDTOToDomainMapper
final class MoviesByTitleDTOToDomainMapper {
    func mapModel(_ model: MoviesByTitleResponseDTO) -> MoviesByTitleResponse {
        MoviesByTitleResponse(
            movies: model.movieResults?.map { dto in
                BasicMovie(
                    title: dto.title,
                    year: dto.year,
                    imdbID: dto.imdbID
                )
            } ?? []
        )
    }
}
