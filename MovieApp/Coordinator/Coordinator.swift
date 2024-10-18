//
//  Navigator.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import UIKit
import Factory

// MARK: - Coordinator
protocol Coordinator {
    var window: UIWindow? { get }
    var navigationController: UINavigationController { get set }
    func start()
}

// MARK: - MovieCoordinator
final class MovieCoordinator: Coordinator {
    
    // MARK: Properties
    var window: UIWindow?
    var navigationController: UINavigationController

    // MARK: Initializer
    init(
        window: UIWindow?,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.navigationController = navigationController
    }

    // MARK: Methods
    func start() {
        let viewModel = DefaultTrendingMoviesViewModel(coordinator: self)
        let trendingMoviesVC = TrendingMoviesViewController(viewModel: viewModel)
        navigationController.viewControllers = [trendingMoviesVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToMovieDetails(with id: String) {
        let viewModel = DefaultMovieDetailsViewModel(movieId: id)
        let detailsVc = MovieDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(detailsVc, animated: true)
    }
}
