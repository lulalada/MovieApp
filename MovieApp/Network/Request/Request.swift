//
//  Request.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 17/10/2024.
//

import Foundation

public protocol Request {
    var route: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: BodyType { get }
    var query: [String: String] { get }

    associatedtype ResponseType: Decodable
}

public extension Request {
    var method: HTTPMethod { .GET }
    var headers: [String: String] {
        [
            "x-rapidapi-key": "88a659b4fbmsh0114af9ee0c46d6p1dc0dajsn251a2653177e",
            "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com",
        ]
    }
    var query: [String: String] { [:] }
}

// MARK: - HTTPMethod
public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: - BodyType
public enum BodyType {
    case encodable(Encodable)
    case empty
}
