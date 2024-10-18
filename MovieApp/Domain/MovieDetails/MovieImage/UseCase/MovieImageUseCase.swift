//
//  MovieImageUseCase.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine
import Factory

// MARK: - MovieImageUseCase
protocol MovieImageUseCase {
    func execute(request: MovieImageRequest) -> AnyPublisher<MovieImageResponse, NetworkError>
}

// MARK: - DefaultMovieImageUseCase
final class DefaultMovieImageUseCase {
    
    // MARK: Injected
    @LazyInjected(\.movieDetailsContainer.movieImageRepository)
    private var repository: MovieImageRepository
}

// MARK: - MovieByIDUseCase
extension DefaultMovieImageUseCase: MovieImageUseCase {
    func execute(request: MovieImageRequest) -> AnyPublisher<MovieImageResponse, NetworkError> {
        repository.fetchMovieImage(parameters: request)
    }
}
