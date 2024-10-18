//
//  MovieDetailsContainer.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import Factory
import Foundation

// MARK: - MovieDetailsContainer
final class MovieDetailsContainer: SharedContainer {
    
    // MARK: Static
    static let shared = MovieDetailsContainer(manager: .init())
    
    // MARK: Properties
    let manager: ContainerManager
    
    // MARK: Initializer
    init(manager: ContainerManager) {
        self.manager = manager
    }
}

// MARK: - Services
extension MovieDetailsContainer {
    // MARK: MovieByID
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
    
    // MARK: MovieImage
    var movieImageUseCase: Factory<MovieImageUseCase> {
        self { DefaultMovieImageUseCase() }
    }
    
    var movieImageRepository: Factory<MovieImageRepository> {
        self { DefaultMovieImageRepository() }
    }
    
    var movieImageDataSource: Factory<MovieImageDataSource> {
        self { DefaultMovieImageDataSource() }
    }
    
    var movieImageDomainToDTOMapper: Factory<MovieImageDomainToDTOMapper> {
        self { MovieImageDomainToDTOMapper() }
    }
    
    var movieImageDTOToDomainMapper: Factory<MovieImageDTOToDomainMapper> {
        self { MovieImageDTOToDomainMapper() }
    }
}
