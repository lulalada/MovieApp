//
//  TrendingMoviesUseCase.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine
import Factory

// MARK: - TrendingMoviesUseCase
protocol TrendingMoviesUseCase {
    func execute(request: TrendingMoviesRequest) -> AnyPublisher<TrendingMoviesResponse, NetworkError>
}

// MARK: - DefaultTrendingMoviesUseCase
final class DefaultTrendingMoviesUseCase {
    
    // MARK: Injected
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesRepository)
    private var repository: TrendingMoviesRepository
}

// MARK: - TrendingMoviesUseCase
extension DefaultTrendingMoviesUseCase: TrendingMoviesUseCase {
    func execute(request: TrendingMoviesRequest) -> AnyPublisher<TrendingMoviesResponse, NetworkError> {
        repository.fetchTrendingMovies(parameters: request)
    }
}
