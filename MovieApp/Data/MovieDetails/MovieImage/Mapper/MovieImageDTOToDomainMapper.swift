//
//  MovieImageDTOToDomainMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MovieImageDTOToDomainMapper
final class MovieImageDTOToDomainMapper {
    func mapModel(_ model: MovieImageResponseDTO) -> MovieImageResponse {
        MovieImageResponse(posterUrl: model.poster)
    }
}
