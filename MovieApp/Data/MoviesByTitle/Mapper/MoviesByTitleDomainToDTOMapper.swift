//
//  MoviesByTitleDomainToDTOMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - MoviesByTitleDomainToDTOMapper
final class MoviesByTitleDomainToDTOMapper {
    func mapModel(_ model: MoviesByTitleRequest) -> MoviesByTitleRequestDTO {
        MoviesByTitleRequestDTO(title: model.title)
    }
}
