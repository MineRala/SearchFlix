//
//  CollectionViewCell.swift
//  SearchFlix
//
//  Created by Mine Rala on 17.02.2025.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        posterImageView.image = nil
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    func configure(with imageURL: String) {
        guard imageURL != "N/A" else {
            posterImageView.image = UIImage(named: "na")
            return
        }
        CacheManager.shared.loadImage(from: imageURL) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
    }
}
