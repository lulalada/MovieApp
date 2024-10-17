//
//  DefaultMovieByIDRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - DefaultMovieByIDRepository
final class DefaultMovieByIDRepository {
    
    // MARK: Injected
    @LazyInjected(\.movieByIDContainer.movieByIDDomainToDTOMapper)
    private var domainToDTOMapper: MovieByIDDomainToDTOMapper
    
    @LazyInjected(\.movieByIDContainer.movieByIDDTOToDomainMapper)
    private var dtoToDomainMapper: MovieByIDDTOToDomainMapper
    
    @LazyInjected(\.movieByIDContainer.movieByIDDataSource)
    private var dataSource: MovieByIDDataSource
}

// MARK: - MovieByIDRepository
extension DefaultMovieByIDRepository: MovieByIDRepository {
    func fetchMovieByID(parameters: MovieByIDRequest) -> AnyPublisher<Movie, NetworkError> {
        dataSource.fetchMovieByID(dto: domainToDTOMapper.mapModel(parameters))
            .compactMap { [weak self] response in
                self?.dtoToDomainMapper.mapModel(response)
            }
            .eraseToAnyPublisher()
    }
}
