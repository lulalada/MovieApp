//
//  MoviesByTitleDataSource.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - MoviesByTitleDataSource
protocol MoviesByTitleDataSource {
    func fetchMoviesByTitle(dto: MoviesByTitleRequestDTO) -> AnyPublisher<MoviesByTitleResponseDTO, NetworkError>
}

// MARK: - DefaultMoviesByTitleDataSource
final class DefaultMoviesByTitleDataSource {
    
    // MARK: Injected
    @LazyInjected(\.networkManager)
    private var networkManager: NetworkManagerProtocol
}

// MARK: - MoviesByTitleDataSource
extension DefaultMoviesByTitleDataSource: MoviesByTitleDataSource {
    func fetchMoviesByTitle(dto: MoviesByTitleRequestDTO) -> AnyPublisher<MoviesByTitleResponseDTO, NetworkError> {
        networkManager.request(GetMoviesByTitleRequest(requestDTO: dto))
    }
}
