//
//  MovieByIDContainer.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Foundation

// MARK: - MovieByIDContainer
final class MovieByIDContainer: SharedContainer {
    
    // MARK: Static
    static let shared = MovieByIDContainer(manager: .init())
    
    // MARK: Properties
    let manager: ContainerManager
    
    // MARK: Initializer
    init(manager: ContainerManager) {
        self.manager = manager
    }
}

// MARK: - Services
extension MovieByIDContainer {
    var movieByIDUseCase: Factory<MovieByIDUseCase> {
        self { DefaultMovieByIDUseCase() }
    }
    
    var movieByIDRepository: Factory<MovieByIDRepository> {
        self { DefaultMovieByIDRepository() }
    }
    
    var movieByIDDataSource: Factory<MovieByIDDataSource> {
        self { DefaultMovieByIDDataSource() }
    }
    
    var movieByIDDomainToDTOMapper: Factory<MovieByIDDomainToDTOMapper> {
        self { MovieByIDDomainToDTOMapper() }
    }
    
    var movieByIDDTOToDomainMapper: Factory<MovieByIDDTOToDomainMapper> {
        self { MovieByIDDTOToDomainMapper() }
    }
}
