//
//  MoviesByTitleRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine

// MARK: - MoviesByTitleRepository
protocol MoviesByTitleRepository {
    func fetchMoviesByTitle(parameters: MoviesByTitleRequest) -> AnyPublisher<MoviesByTitleResponse, NetworkError>
}
