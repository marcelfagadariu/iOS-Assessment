//
//  ArtDetailViewController.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit

final class ArtDetailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ArtDetailViewModel
    private let artDetailView = ArtDetailView()

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
        view.addSubview(artDetailView)
        artDetailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            artDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            artDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            artDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        artDetailView.configure(with: viewModel)
    }
}
