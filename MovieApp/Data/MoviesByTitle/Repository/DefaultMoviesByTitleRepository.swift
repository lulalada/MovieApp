//
//  DefaultMoviesByTitleRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - DefaultMoviesByTitleRepository
final class DefaultMoviesByTitleRepository {
    
    // MARK: Injected
    @LazyInjected(\.moviesByTitleContainer.moviesByTitleDomainToDTOMapper)
    private var domainToDTOMapper: MoviesByTitleDomainToDTOMapper
    
    @LazyInjected(\.moviesByTitleContainer.moviesByTitleDTOToDomainMapper)
    private var dtoToDomainMapper: MoviesByTitleDTOToDomainMapper
    
    @LazyInjected(\.moviesByTitleContainer.moviesByTitleDataSource)
    private var dataSource: MoviesByTitleDataSource
}

// MARK: - MoviesByTitleRepository
extension DefaultMoviesByTitleRepository: MoviesByTitleRepository {
    
    func fetchMoviesByTitle(parameters: MoviesByTitleRequest) -> AnyPublisher<MoviesByTitleResponse, NetworkError> {
        dataSource.fetchMoviesByTitle(dto: domainToDTOMapper.mapModel(parameters))
            .compactMap { [weak self] response in
                self?.dtoToDomainMapper.mapModel(response)
            }
            .eraseToAnyPublisher()
    }
}
