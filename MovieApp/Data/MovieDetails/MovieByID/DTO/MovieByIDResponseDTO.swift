//
//  MovieByIDResponseDTO.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

// MARK: - MovieByIDResponseDTO
struct MovieByIDResponseDTO: Decodable {
    let title: String?
    let description: String?
    let tagline: String?
    let year: String?
    let releaseDate: String?
    let imdbID: String
    let imdbRating: String?
    let voteCount: String?
    let popularity: String?
    let rated: String?
    let genres: [String]?
    let stars: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case tagline
        case year
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case voteCount = "vote_count"
        case popularity
        case rated
        case genres
        case stars
    }
}
