//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Foundation
import Combine
import Factory

// MARK: - MovieDetailsViewModelOutput
protocol MovieDetailsViewModelOutput {
    var moviePublisher: AnyPublisher<Movie, Never> { get }
}

// MARK: - MovieDetailsViewModel
typealias MovieDetailsViewModel = MovieDetailsViewModelOutput

// MARK: - DefaultMovieDetailsViewModel
final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    // MARK: Injected
    @LazyInjected(\.movieByIDContainer.movieByIDUseCase)
    var movieByIDUseCase: MovieByIDUseCase
    
    // MARK: Publisher
    var moviePublisher: AnyPublisher<Movie, Never> {
        movieSubject.eraseToAnyPublisher()
    }
    
    private let movieSubject = PassthroughSubject<Movie, Never>()
    
    // MARK: Properties
    private(set) var subscriptions: Set<AnyCancellable> = []
    
    init(movieId: String) {
        getMovieDetails(by: movieId)
    }
}

// MARK: - Private method
private extension DefaultMovieDetailsViewModel {
    func getMovieDetails(by id: String) {
        movieByIDUseCase
            .execute(request: .init(movieId: id))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure:
                    print("failure")
                }
            } receiveValue: { [weak self] response in
                guard let self else {
                    return
                }
                self.movieSubject.send(response)
            }
            .store(in: &subscriptions)
    }
}
