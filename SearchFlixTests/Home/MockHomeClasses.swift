//
//  MockHomeClasses.swift
//  SearchFlixTests
//
//  Created by Mine Rala on 4.03.2025.
//

import Foundation
@testable import SearchFlix

// MARK: - MockHomeInteractorOutput
final class MockHomeInteractorOutput: HomeInteractorOutputProtocol {
    var fetchedMovies: [MovieModel]? = nil
    var fetchError: Error?
    var fetchType: FetchType?
    var isDidFetchMoviesCalled = false
    var isDidFailToFetchMoviesCalled = false

    func didFetchMovies(_ movies: [MovieModel], for type: FetchType) {
        fetchedMovies = movies
        fetchType = type
        isDidFetchMoviesCalled = true
    }

    func didFailToFetchMovies(with error: Error, for type: FetchType) {
        fetchError = error
        fetchType = type
        isDidFailToFetchMoviesCalled = true
    }
}
