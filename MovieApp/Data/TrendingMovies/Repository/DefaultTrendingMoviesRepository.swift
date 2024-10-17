//
//  DefaultTrendingMoviesRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Combine

// MARK: - DefaultTrendingMoviesRepository
final class DefaultTrendingMoviesRepository {
    
    // MARK: Injected
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesDomainToDTOMapper)
    private var domainToDTOMapper: TrendingMoviesDomainToDTOMapper
    
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesDTOToDomainMapper)
    private var dtoToDomainMapper: TrendingMoviesDTOToDomainMapper
    
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesDataSource)
    private var dataSource: TrendingMoviesDataSource
}

// MARK: - TrendingMoviesRepository
extension DefaultTrendingMoviesRepository: TrendingMoviesRepository {
    
    func fetchTrendingMovies(parameters: TrendingMoviesRequest) -> AnyPublisher<TrendingMoviesResponse, NetworkError> {
        dataSource.fetchTrendingMovies(dto: domainToDTOMapper.mapModel(parameters))
            .compactMap { [weak self] response in
                self?.dtoToDomainMapper.mapModel(response)
            }
            .eraseToAnyPublisher()
    }
}
