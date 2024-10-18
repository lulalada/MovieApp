//
//  MoviesByTitleContainer.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Foundation

// MARK: - MoviesByTitleContainer
final class MoviesByTitleContainer: SharedContainer {
    
    // MARK: Static
    static let shared = MoviesByTitleContainer(manager: .init())
    
    // MARK: Properties
    let manager: ContainerManager
    
    // MARK: Initializer
    init(manager: ContainerManager) {
        self.manager = manager
    }
}

// MARK: - Services
extension MoviesByTitleContainer {
    var moviesByTitleUseCase: Factory<MoviesByTitleUseCase> {
        self { DefaultMoviesByTitleUseCase() }
    }
    
    var moviesByTitleRepository: Factory<MoviesByTitleRepository> {
        self { DefaultMoviesByTitleRepository() }
    }
    
    var moviesByTitleDataSource: Factory<MoviesByTitleDataSource> {
        self { DefaultMoviesByTitleDataSource() }
    }
    
    var moviesByTitleDomainToDTOMapper: Factory<MoviesByTitleDomainToDTOMapper> {
        self { MoviesByTitleDomainToDTOMapper() }
    }
    
    var moviesByTitleDTOToDomainMapper: Factory<MoviesByTitleDTOToDomainMapper> {
        self { MoviesByTitleDTOToDomainMapper() }
    }
}
