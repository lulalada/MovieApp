//
//  MovieByIDDTOToDomainMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MovieByIDDTOToDomainMapper
final class MovieByIDDTOToDomainMapper {
    func mapModel(_ model: MovieByIDResponseDTO) -> Movie {
        Movie(
            imdbID: model.imdbID,
            title: model.title,
            description: model.description,
            tagline: model.tagline,
            year: model.year,
            releaseDate: model.releaseDate,
            rating: model.imdbRating,
            voteCount: model.voteCount,
            popularity: model.popularity,
            rated: model.rated
        )
    }
}
