//
//  TrendingMoviesViewModel.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Foundation
import Combine
import Factory

// MARK: - TrendingMoviesViewModelInput
protocol TrendingMoviesViewModelInput {
    func getTrendingMovies()
    func getMoviesByTitle(_ title: String)
    // func loadMoreTrendingMovies()
}

// MARK: - TrendingMoviesViewModelOutput
protocol TrendingMoviesViewModelOutput {
    var moviesPublisher: AnyPublisher<[BasicMovie], Never> { get }
}

// MARK: - TrendingMoviesViewModel
typealias TrendingMoviesViewModel = TrendingMoviesViewModelInput & TrendingMoviesViewModelOutput

// MARK: - DefaultTrendingMoviesViewModel
final class DefaultTrendingMoviesViewModel: TrendingMoviesViewModel {
    
    // MARK: Injected
    @LazyInjected(\.trendingMoviesContainer.trendingMoviesUseCase)
    var trendingMoviesUseCase: TrendingMoviesUseCase
    
    @LazyInjected(\.moviesByTitleContainer.moviesByTitleUseCase)
    var moviesByTitleUseCase: MoviesByTitleUseCase
    
    // MARK: Publisher
    var moviesPublisher: AnyPublisher<[BasicMovie], Never> {
        moviesSubject.eraseToAnyPublisher()
    }
    
    private let moviesSubject = PassthroughSubject<[BasicMovie], Never>()
    
    // MARK: Properties
    private var pagesCounter: Int = 2
    private(set) var subscriptions: Set<AnyCancellable> = []
}

// MARK: - Input
extension DefaultTrendingMoviesViewModel {
    func getTrendingMovies() {
        trendingMoviesUseCase
            .execute(request: .init(page: pagesCounter))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.moviesSubject.send(response.movies)
            }
            .store(in: &subscriptions)
    }
    
    func getMoviesByTitle(_ title: String) {
        moviesByTitleUseCase
            .execute(request: .init(title: title))
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.moviesSubject.send(response.movies)
            }
            .store(in: &subscriptions)
    }
}
