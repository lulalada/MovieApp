//
//  DefaultMovieImageRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - DefaultMovieImageRepository
final class DefaultMovieImageRepository {
    
    // MARK: Injected
    @LazyInjected(\.movieDetailsContainer.movieImageDomainToDTOMapper)
    private var domainToDTOMapper: MovieImageDomainToDTOMapper
    
    @LazyInjected(\.movieDetailsContainer.movieImageDTOToDomainMapper)
    private var dtoToDomainMapper: MovieImageDTOToDomainMapper
    
    @LazyInjected(\.movieDetailsContainer.movieImageDataSource)
    private var dataSource: MovieImageDataSource
}

// MARK: - MovieByIDRepository
extension DefaultMovieImageRepository: MovieImageRepository {
    func fetchMovieImage(parameters: MovieImageRequest) -> AnyPublisher<MovieImageResponse, NetworkError> {
        dataSource.fetchMovieImage(dto: domainToDTOMapper.mapModel(parameters))
            .compactMap { [weak self] response in
                self?.dtoToDomainMapper.mapModel(response)
            }
            .eraseToAnyPublisher()
    }
}
