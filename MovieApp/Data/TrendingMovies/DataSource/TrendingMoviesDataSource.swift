//
//  TrendingMoviesDataSource.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - TrendingMoviesDataSource
protocol TrendingMoviesDataSource {
    func fetchTrendingMovies(dto: TrendingMoviesRequestDTO) -> AnyPublisher<TrendingMoviesResponseDTO, NetworkError>
}

// MARK: - DefaultTrendingMoviesDataSource
final class DefaultTrendingMoviesDataSource {
    
    // MARK: Injected
    @LazyInjected(\.networkManager)
    private var networkManager: NetworkManagerProtocol
}

// MARK: - TrendingMoviesDataSource
extension DefaultTrendingMoviesDataSource: TrendingMoviesDataSource {
    func fetchTrendingMovies(dto: TrendingMoviesRequestDTO) -> AnyPublisher<TrendingMoviesResponseDTO, NetworkError> {
        networkManager.request(GetTrendingMoviesRequest(requestDTO: dto))
    }
}
