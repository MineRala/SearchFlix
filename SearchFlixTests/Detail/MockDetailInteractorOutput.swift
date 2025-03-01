//
//  MockDetailInteractorOutput.swift
//  SearchFlixTests
//
//  Created by Mine Rala on 1.03.2025.
//

import UIKit
@testable import SearchFlix

//Çünkü DetailInteractor içinde output?.didFetchMovieDetails(movie, image: nil) çağrılıyor ve biz bunun çağrılıp çağrılmadığını test etmek istiyoruz.
//Eğer DetailInteractorOutput için bir mock nesne oluşturmazsak, DetailInteractor'ın bu metodu gerçekten çağırıp çağırmadığını bilemeyiz.

final class MockDetailInteractorOutput: DetailInteractorOutput {
    var receivedMovie: MovieModel?
    var receivedImage: UIImage?
    var didFetchMovieDetailsCalled = false

    func didFetchMovieDetails(_ movie: MovieModel, image: UIImage?) {
        didFetchMovieDetailsCalled = true
        receivedMovie = movie
        receivedImage = image
    }
}
