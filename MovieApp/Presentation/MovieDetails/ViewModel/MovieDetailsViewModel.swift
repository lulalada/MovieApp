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
    var movieImagePublisher: AnyPublisher<String, Never> { get }
}

// MARK: - MovieDetailsViewModel
typealias MovieDetailsViewModel = MovieDetailsViewModelOutput

// MARK: - DefaultMovieDetailsViewModel
final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    // MARK: Injected
    @LazyInjected(\.movieDetailsContainer.movieByIDUseCase)
    var movieByIDUseCase: MovieByIDUseCase
    
    @LazyInjected(\.movieDetailsContainer.movieImageUseCase)
    var movieImageUseCase: MovieImageUseCase
    
    // MARK: Publisher
    var moviePublisher: AnyPublisher<Movie, Never> {
        movieSubject.eraseToAnyPublisher()
    }
    
    var movieImagePublisher: AnyPublisher<String, Never> {
        movieImageSubject.eraseToAnyPublisher()
    }
    
    private let movieSubject = PassthroughSubject<Movie, Never>()
    private let movieImageSubject = PassthroughSubject<String, Never>()
    
    // MARK: Properties
    private(set) var subscriptions: Set<AnyCancellable> = []
    
    init(movieId: String) {
        getMovieDetails(by: movieId)
//        getMovieImage(by: movieId)
    }
}

// MARK: - Private method
private extension DefaultMovieDetailsViewModel {
    func getMovieDetails(by id: String) {
        print(id)
        movieByIDUseCase
            .execute(request: .init(movieId: id))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print("Error from details: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.movieSubject.send(response)
            }
            .store(in: &subscriptions)
    }
    
    func getMovieImage(by id: String) {
        movieImageUseCase
            .execute(request: .init(movieId: id))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print("Error from image: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.movieImageSubject.send(response.posterUrl)
            }
            .store(in: &subscriptions)
    }
}
