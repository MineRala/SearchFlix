//
//  HomeViewController.swift
//  SearchFlix
//
//  Created by Mine Rala on 17.02.2025.
//

import UIKit

final class HomeViewController: UIViewController {

    // UI Elements
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red // İstediğiniz renk
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    // Sample Data
    private let sampleMovies: [MovieModel] = [
        MovieModel(title: "Movie 1", year: "2021", id: "", type: "Action", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg"),
        MovieModel(title: "Movie 2", year: "2020", id: "", type: "Comedy", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg"),
        MovieModel(title: "Movie 1", year: "2021", id: "", type: "Action", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg"),
        MovieModel(title: "Movie 2", year: "2020", id: "", type: "Comedy", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg"),

        MovieModel(title: "Movie 1", year: "2021", id: "", type: "Action", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg"),
        MovieModel(title: "Movie 2", year: "2020", id: "", type: "Comedy", image: "https://m.media-amazon.com/images/M/MV5BYjJjOTg4MmEtNTlhMy00NmZlLTlhNTAtZmQ5MjJhYTMyYzIxXkEyXkFqcGc@._V1_SX300.jpg")

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }

    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(separatorView) // Separator ekledik

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            separatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10), // Separator table view'un altına ekleniyor
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1), // İnce bir çizgi

            collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10), // Collection view'u separator'ın altına yerleştiriyoruz
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

            tableView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = sampleMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle table view cell tap if needed
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = sampleMovies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: movie.image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle collection view item tap if needed
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 260, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

}
