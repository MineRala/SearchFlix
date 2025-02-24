//
//  DetailPresenter.swift
//  SearchFlix
//
//  Created by Mine Rala on 24.02.2025.
//

import UIKit

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class DetailPresenter {
    weak var view: DetailViewProtocol?
    private let interactor: DetailInteractorProtocol

    init(view: DetailViewProtocol, interactor: DetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - DetailPresenterProtocol
extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        interactor.getMovieDetails()
    }
}

// MARK: - DetailInteractorOutput
extension DetailPresenter: DetailInteractorOutput {
    func didFetchMovieDetails(_ movie: MovieModel, imageData: Data?) {
        view?.displayMovieDetails(movie, image: UIImage.fromData(imageData))
    }
}
