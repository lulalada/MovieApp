//
//  MoviesByTitleUseCase.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Combine
import Factory

// MARK: - MoviesByTitleUseCase
protocol MoviesByTitleUseCase {
    func execute(request: MoviesByTitleRequest) -> AnyPublisher<MoviesByTitleResponse, NetworkError>
}

// MARK: - DefaultMoviesByTitleUseCase
final class DefaultMoviesByTitleUseCase {
    
    // MARK: Injected
    @LazyInjected(\.moviesByTitleContainer.moviesByTitleRepository)
    private var repository: MoviesByTitleRepository
}

// MARK: - MoviesByTitleUseCase
extension DefaultMoviesByTitleUseCase: MoviesByTitleUseCase {
    func execute(request: MoviesByTitleRequest) -> AnyPublisher<MoviesByTitleResponse, NetworkError> {
        repository.fetchMoviesByTitle(parameters: request)
    }
}
