//
//  MovieByIDUseCase.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine
import Factory

// MARK: - MovieByIDUseCase
protocol MovieByIDUseCase {
    func execute(request: MovieByIDRequest) -> AnyPublisher<Movie, NetworkError>
}

// MARK: - DefaultMovieByIDUseCase
final class DefaultMovieByIDUseCase {
    
    // MARK: Injected
    @LazyInjected(\.movieDetailsContainer.movieByIDRepository)
    private var repository: MovieByIDRepository
}

// MARK: - MovieByIDUseCase
extension DefaultMovieByIDUseCase: MovieByIDUseCase {
    func execute(request: MovieByIDRequest) -> AnyPublisher<Movie, NetworkError> {
        repository.fetchMovieByID(parameters: request)
    }
}
