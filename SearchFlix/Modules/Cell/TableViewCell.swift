//
//  TableViewCell.swift
//  SearchFlix
//
//  Created by Mine Rala on 17.02.2025.
//

import UIKit

final class TableViewCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    private lazy var typeAndYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        typeAndYearLabel.text = nil
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(typeAndYearLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4),
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            typeAndYearLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -8),
            typeAndYearLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            typeAndYearLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with movie: MovieModel) {
        CacheManager.shared.loadImage(from: movie.image) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
        titleLabel.text = movie.title
        typeAndYearLabel.text = "\(movie.type) - \(movie.year)"

    }
}
