//
//  MovieImageRepository.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine

// MARK: - MovieImageRepository
protocol MovieImageRepository {
    func fetchMovieImage(parameters: MovieImageRequest) -> AnyPublisher<MovieImageResponse, NetworkError>
}
