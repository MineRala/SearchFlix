//
//  Enpoint.swift
//  SearchFlix
//
//  Created by Mine Rala on 17.02.2025.
//

import Foundation

//http://www.omdbapi.com/?s=movieSearchTitle&apikey=48a7fc03
//http://www.omdbapi.com/?i=movieIMBID=&apikey=48a7fc03

enum Endpoint {
    enum Constant {
        static let baseURL = "http://www.omdbapi.com"
        static let apiKey = "48a7fc03"
    }

    case movieSearchTitle(movieSearchTitle: String, page: String)
    case detailMovie(movieIMBID: String)

    var url: URL? {
        switch self {
        case .movieSearchTitle(let movieSearchTitle, let page):
            return URL(string: "\(Constant.baseURL)?s=\(movieSearchTitle)&page=\(page)&apiKey=\(Constant.apiKey)")
        case .detailMovie(let movieIMBID):
            return URL(string: "\(Constant.baseURL)?i=\(movieIMBID)&apikey=\(Constant.apiKey)")
        }
    }
}
