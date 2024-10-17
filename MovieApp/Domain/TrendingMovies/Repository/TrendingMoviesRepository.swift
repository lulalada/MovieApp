//
//  TrendingMoviesRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine

// MARK: - TrendingMoviesRepository
protocol TrendingMoviesRepository {
    func fetchTrendingMovies(parameters: TrendingMoviesRequest) -> AnyPublisher<TrendingMoviesResponse, NetworkError>
}
