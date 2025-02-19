//
//  SearchModel.swift
//  SearchFlix
//
//  Created by Mine Rala on 18.02.2025.
//

import Foundation

struct SearchModel: Decodable {
    var search: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct MovieModel: Decodable {
    var title: String
    var year: String
    var id: String
    var type: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case image = "Poster"
    }
}
