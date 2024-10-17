//
//  MovieByIDDomainToDTOMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MovieByIDDomainToDTOMapper
final class MovieByIDDomainToDTOMapper {
    func mapModel(_ model: MovieByIDRequest) -> MovieByIDRequestDTO {
        MovieByIDRequestDTO(movieid: model.movieId)
    }
}
