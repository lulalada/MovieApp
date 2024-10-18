//
//  TrendingMoviesContainer.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Foundation

// MARK: - TrendingMoviesContainer
final class TrendingMoviesContainer: SharedContainer {
    
    // MARK: Static
    static let shared = TrendingMoviesContainer(manager: .init())
    
    // MARK: Properties
    let manager: ContainerManager
    
    // MARK: Initializer
    init(manager: ContainerManager) {
        self.manager = manager
    }
}

// MARK: - Services
extension TrendingMoviesContainer {
    var trendingMoviesUseCase: Factory<TrendingMoviesUseCase> {
        self { DefaultTrendingMoviesUseCase() }
    }
    
    var trendingMoviesRepository: Factory<TrendingMoviesRepository> {
        self { DefaultTrendingMoviesRepository() }
    }
    
    var trendingMoviesDataSource: Factory<TrendingMoviesDataSource> {
        self { DefaultTrendingMoviesDataSource() }
    }
    
    var trendingMoviesDomainToDTOMapper: Factory<TrendingMoviesDomainToDTOMapper> {
        self { TrendingMoviesDomainToDTOMapper() }
    }
    
    var trendingMoviesDTOToDomainMapper: Factory<TrendingMoviesDTOToDomainMapper> {
        self { TrendingMoviesDTOToDomainMapper() }
    }
}
