//
//  MovieByIDRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine

// MARK: - MovieByIDRepository
protocol MovieByIDRepository {
    func fetchMovieByID(parameters: MovieByIDRequest) -> AnyPublisher<Movie, NetworkError>
}
