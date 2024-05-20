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
        self.backgroundColor = .clear

        // Setup containerView
        containerView.frame = CGRect(x: 10, y: 10, width: self.contentView.frame.width - 20, height: self.contentView.frame.height - 20)
        containerView.backgroundColor = .clear
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.cornerRadius = 8
        self.contentView.addSubview(containerView)

        // Setup titleLabel
        titleLabel.frame = CGRect(x: 10, y: 10, width: containerView.frame.width - 20, height: 30)
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 15)
        containerView.addSubview(titleLabel)

        // Setup descriptionLabel
        descriptionLabel.frame = CGRect(x: 10, y: titleLabel.frame.maxY + 5, width: containerView.frame.width - 20, height: 30)
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
        descriptionLabel.numberOfLines = 2
        containerView.addSubview(descriptionLabel)

        // Setup imageView
        imageView.frame = CGRect(x: 10, y: descriptionLabel.frame.maxY + 5, width: containerView.frame.width - 20, height: containerView.frame.height - descriptionLabel.frame.maxY - 15)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        containerView.addSubview(imageView)
    }

    // MARK: - Methods

    func setupCell(with art: Art) {
        titleLabel.text = art.title
        descriptionLabel.text = art.longTitle
        descriptionLabel.sizeToFit()

        if art.hasImage {
            let url = URL(string: art.webImage.url)
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }

}
