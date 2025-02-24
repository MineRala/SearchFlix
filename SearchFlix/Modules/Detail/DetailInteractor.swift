//
//  DetailInteractor.swift
//  SearchFlix
//
//  Created by Mine Rala on 24.02.2025.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject{
    var output: DetailInteractorOutput? { get set }
    func getMovieDetails()
}

protocol DetailInteractorOutput: AnyObject {
    func didFetchMovieDetails(_ movie: MovieModel, imageData: Data?)
}

final class DetailInteractor {
    public weak var output: DetailInteractorOutput?
    private let cacheManager: CacheManagerInterface
    private let movie: MovieModel

    init(cacheManager: CacheManagerInterface = CacheManager.shared, movie: MovieModel) {
        self.cacheManager = cacheManager
        self.movie = movie
    }
}

// MARK: - DetailInteractorProtocol
extension DetailInteractor:  DetailInteractorProtocol {
    func getMovieDetails() {
        if movie.image == "N/A" {
            output?.didFetchMovieDetails(movie, imageData: nil)
        } else {
            let cachedImage = cacheManager.getImage(for: movie.image)
            let imageData = cachedImage?.pngData()
            output?.didFetchMovieDetails(movie, imageData: imageData)
        }
    }
}
