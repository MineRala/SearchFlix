//
//  HomeViewController.swift
//  SearchFlix
//
//  Created by Mine Rala on 17.02.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
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
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .black
        indicator.isHidden = true
        return indicator
    }()

    private var isFirstFetch = true
    private var searchPage = 1
    private var collectionPage = 1
    private var isFetchingMoreCollectionMovies = false
    private var isFetchingMoreSearchMovies = false
    private var searchText = "Star"

    private var isLoading = false {
        didSet {
            loadingIndicator.isHidden = !isLoading
            isLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
            tableView.isHidden = isLoading
            if isFirstFetch {
                collectionView.isHidden = isLoading
            } else {
                collectionView.isHidden = false
            }
        }
    }

    private var searchMovies: [MovieModel] = []
    private var collectionMovies: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        fetchInitialData()
    }

    private func setupNavigationBar() {
        title = "SearchFlix"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            collectionView.heightAnchor.constraint(equalToConstant: 230),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 0)
    }

    private func fetchInitialData() {
        isLoading = true
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        fetchSearchMovies(searchText: searchText) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.enter()
        fetchSearchMoviesForCollection {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            self.isFirstFetch = false
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }

    func fetchSearchMovies(searchText: String, completion: @escaping () -> Void){
        NetworkManager.shared.makeRequest(endpoint: .movieSearchTitle(movieSearchTitle: "\(searchText)", page: "\(searchPage)"), type: SearchModel.self) { result in
            switch result {
            case .success(let success):
                self.searchPage == 1 ? self.searchMovies = success.search : self.searchMovies.append(contentsOf: success.search)
            case .failure(let failure):
                print(failure)
                self.showAlert(message: "Something went wrong. Please try again later.")
                self.searchMovies.removeAll()
            }
            completion()
        }
    }

    func fetchSearchMoviesForCollection(completion: @escaping () -> Void){
        NetworkManager.shared.makeRequest(endpoint: .movieSearchTitle(movieSearchTitle: "Comedy", page: "\(collectionPage)"), type: SearchModel.self) { result in
            switch result {
            case .success(let success):
                self.collectionPage == 1 ? self.collectionMovies = success.search : self.collectionMovies.append(contentsOf: success.search)
            case .failure(let failure):
                print(failure)
                self.showAlert(message: "Something went wrong. Please try again later.")
                self.collectionMovies.removeAll()
            }
            completion()
        }
    }

    private func loadMoreCollectionMovies() {
        guard !isFetchingMoreCollectionMovies else { return }
        isFetchingMoreCollectionMovies = true
        collectionPage += 1

        fetchSearchMoviesForCollection {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.isFetchingMoreCollectionMovies = false
            }
        }
    }

    private func loadMoreSearchMovies() {
        guard !isFetchingMoreSearchMovies else { return }
        isFetchingMoreSearchMovies = true
        searchPage += 1

        fetchSearchMovies(searchText: searchText) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.isFetchingMoreSearchMovies = false
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = searchMovies[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Unable to dequeue TableViewCell")
        }

        cell.selectionStyle = .none
        cell.configure(with: movie)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(movie: searchMovies[indexPath.row]), animated: true)
        print("Selected movie: \(searchMovies[indexPath.row].title)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == searchMovies.count - 3 && !isFetchingMoreSearchMovies {
            loadMoreSearchMovies()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = collectionMovies[indexPath.item]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue CollectionViewCell")
        }
        cell.configure(with: movie.image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(movie: collectionMovies[indexPath.item]), animated: true)
        print("Selected collection item: \(collectionMovies[indexPath.item].title)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == collectionMovies.count - 3 && !isFetchingMoreCollectionMovies {
            loadMoreCollectionMovies()
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }

        isLoading = true
        searchText = text
        searchPage = 1

        searchMovies.removeAll()

        fetchSearchMovies(searchText: searchText) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
}
