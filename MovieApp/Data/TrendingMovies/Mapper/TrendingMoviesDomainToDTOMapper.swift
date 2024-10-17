//
//  TrendingMoviesDomainToDTOMapper.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

// MARK: - TrendingMoviesDomainToDTOMapper
final class TrendingMoviesDomainToDTOMapper {
    func mapModel(_ model: TrendingMoviesRequest) -> TrendingMoviesRequestDTO {
        TrendingMoviesRequestDTO(page: model.page)
    }
}
