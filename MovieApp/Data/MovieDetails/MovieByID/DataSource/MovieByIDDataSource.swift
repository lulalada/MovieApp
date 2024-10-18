//
//  MovieByIDDataSource.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - MovieByIDDataSource
protocol MovieByIDDataSource {
    func fetchMovieByID(dto: MovieByIDRequestDTO) -> AnyPublisher<MovieByIDResponseDTO, NetworkError>
}

// MARK: - DefaultMovieByIDDataSource
final class DefaultMovieByIDDataSource {
    
    // MARK: Injected
    @LazyInjected(\.networkManager)
    private var networkManager: NetworkManagerProtocol
}

// MARK: - MovieByIDDataSource
extension DefaultMovieByIDDataSource: MovieByIDDataSource {
    func fetchMovieByID(dto: MovieByIDRequestDTO) -> AnyPublisher<MovieByIDResponseDTO, NetworkError> {
        networkManager.request(GetMovieByIDRequest(requestDTO: dto))
    }
}
