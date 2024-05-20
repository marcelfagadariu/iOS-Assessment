//
//  ArtDetailViewController.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit
import Kingfisher

class ArtDetailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ArtDetailViewModel

    // MARK: - Init

    init(viewModel: ArtDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
    }

    // MARK: - Private methods

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        /// Multiline Navigationbar Title
        navigationItem.setValue(2, forKey: "__largeTitleTwoLineMode")
        self.title = viewModel.art.title
    }

    private func setupUI() {
        let artIamgeView = UIImageView()
        if viewModel.art.hasImage {
            let url = URL(string: viewModel.art.webImage.url)
            artIamgeView.kf.setImage(with: url)
        } else {
            artIamgeView.image = UIImage(named: "placeholder")
        }
        artIamgeView.contentMode = .scaleToFill
        artIamgeView.layer.masksToBounds = true
        artIamgeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artIamgeView)

        let descriptionLabel = UILabel()
        descriptionLabel.text = viewModel.art.longTitle
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            artIamgeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artIamgeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            artIamgeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            artIamgeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            artIamgeView.heightAnchor.constraint(equalToConstant: 250),

            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: artIamgeView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
