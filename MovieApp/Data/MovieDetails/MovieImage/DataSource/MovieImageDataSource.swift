//
//  MovieImageDataSource.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - MovieImageDataSource
protocol MovieImageDataSource {
    func fetchMovieImage(dto: MovieImageRequestDTO) -> AnyPublisher<MovieImageResponseDTO, NetworkError>
}

// MARK: - DefaultMovieImageDataSource
final class DefaultMovieImageDataSource {
    
    // MARK: Injected
    @LazyInjected(\.networkManager)
    private var networkManager: NetworkManagerProtocol
}

// MARK: - MovieByIDDataSource
extension DefaultMovieImageDataSource: MovieImageDataSource {
    func fetchMovieImage(dto: MovieImageRequestDTO) -> AnyPublisher<MovieImageResponseDTO, NetworkError> {
        networkManager.request(GetMovieImageRequest(requestDTO: dto))
    }
}
