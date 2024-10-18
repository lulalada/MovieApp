//
//  Injection.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory

// MARK: - Injection
extension Container {
    var trendingMoviesContainer: TrendingMoviesContainer { .shared }
    var movieDetailsContainer: MovieDetailsContainer { .shared }
    var moviesByTitleContainer: MoviesByTitleContainer { .shared }
}

