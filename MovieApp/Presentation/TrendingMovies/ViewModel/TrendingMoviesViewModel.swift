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
    
    // MARK: Publisher
    var moviesPublisher: AnyPublisher<[BasicMovie], Never> {
        moviesSubject.eraseToAnyPublisher()
    }
    
    private let moviesSubject = PassthroughSubject<[BasicMovie], Never>()
    
    // MARK: Properties
    private var pagesCounter: Int = 1
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
                case .failure:
                    print("failure")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.moviesSubject.send(response.movies)
            }
            .store(in: &subscriptions)
    }
}
