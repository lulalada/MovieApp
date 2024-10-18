//
//  TrendingMoviesResponseDTO.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

// MARK: - TrendingMoviesResponseDTO
struct TrendingMoviesResponseDTO: Decodable {
    let movieResults: [BasicMovieDTO]

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
    }
}

// MARK: - BasicMovieDTO
struct BasicMovieDTO: Decodable {
    let title: String
    let year: String?
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID = "imdb_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        imdbID = try container.decode(String.self, forKey: .imdbID)
        
        if let yearInt = try? container.decode(Int.self, forKey: .year) {
            year = String(yearInt)
        } else if let yearString = try? container.decode(String.self, forKey: .year) {
            year = yearString
        } else {
            year = nil
        }
    }
}
