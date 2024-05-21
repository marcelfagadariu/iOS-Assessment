//
//  ArtCollectionViewCell.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit
import Kingfisher

final class ArtCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    // MARK: - Methods

    private func setupViews() {
        backgroundColor = .clear
        setupContainerView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupImageView()
        setupConstraints()
    }

    private func setupContainerView() {
        containerView.backgroundColor = .clear
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }

    private func setupTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
    }

    private func setupDescriptionLabel() {
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
    }

    private func setupImageView() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Methods

    func setupCell(with art: Art) {
        titleLabel.text = art.title
        descriptionLabel.text = art.longTitle
        descriptionLabel.sizeToFit()

        if art.hasImage {
            let url = URL(string: art.webImage.url)
            imageView.kf.setImage(
                with: url,
                options: [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)]
            ) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.imageView.image = value.image
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
