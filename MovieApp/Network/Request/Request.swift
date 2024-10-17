//
//  Request.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import Foundation

// MARK: - Request
protocol Request {
    var route: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: BodyType { get }
    var query: [String: String] { get }

    associatedtype ResponseType: Decodable
}

extension Request {
    var route: String { "https://movies-tv-shows-database.p.rapidapi.com/" }
    var method: HTTPMethod { .GET }
    var headers: [String: String] {
        [
            "x-rapidapi-key": "88a659b4fbmsh0114af9ee0c46d6p1dc0dajsn251a2653177e",
            "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com",
            "Type": "get-movie-details"
        ]
    }
    var query: [String: String] { [:] }
}

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: - BodyType
enum BodyType {
    case encodable(Encodable)
    case empty
}
