//
//  MovieImageDomainToDTOMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MovieImageDomainToDTOMapper
final class MovieImageDomainToDTOMapper {
    func mapModel(_ model: MovieImageRequest) -> MovieImageRequestDTO {
        MovieImageRequestDTO(movieid: model.movieId)
    }
}
