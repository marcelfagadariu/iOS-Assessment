//
//  ArtDetailView.swift
//  EpamAssessment
//
//  Created by Marcel on 20.05.2024.
//

import UIKit
import Kingfisher

class ArtDetailView: UIView {

    // MARK: - Subviews

    private let artImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let placesLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        addSubview(artImageView)
        addSubview(descriptionLabel)
        addSubview(placesLabel)

        artImageView.contentMode = .scaleToFill
        artImageView.layer.masksToBounds = true
        artImageView.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        placesLabel.textAlignment = .left
        placesLabel.numberOfLines = 0
        placesLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            artImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            artImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            artImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            artImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            artImageView.heightAnchor.constraint(equalToConstant: 250),

            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: artImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            placesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            placesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            placesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Configuration

    func configure(with viewModel: ArtDetailViewModel) {
        if viewModel.art.hasImage {
            let url = URL(string: viewModel.art.webImage.url)
            artImageView.kf.setImage(with: url)
        } else {
            artImageView.image = UIImage(named: "placeholder")
        }
        descriptionLabel.text = viewModel.art.longTitle
        let description = viewModel.art.placesDescription
        let text = description.isEmpty ? "" : "Places to check this out: \(description)"
        placesLabel.font = .boldSystemFont(ofSize: 15)
        placesLabel.text = text
    }
}
