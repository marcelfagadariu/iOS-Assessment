//
//  ArtListViewController.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit

final class ArtListViewController: UIViewController {

    // MARK: - Properties

    let viewModel: ArtListViewModel
    private var collectionView: UICollectionView!
    let activityIndicator = UIActivityIndicatorView(frame: UIScreen.main.bounds)

    // MARK: - View did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        /// setup
        setupCollectionView()
        setupNavigation()
        setupActivityIndicator()

        /// callbacks
        setupViewModelCallback()

        /// Request
        viewModel.loadData(with: viewModel.culture, pageSize: viewModel.pageSize)
    }

    // MARK: - Init

    init(viewModel: ArtListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("\(#file) has been deinitalized")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Explore Our Gallery"
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 100)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArtCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ArtHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func handleCultureChange(_ culture: Culture) {
        viewModel.pageSize = 10
        viewModel.art.removeAll()
        viewModel.culture = culture
        viewModel.loadData(with: culture, pageSize: viewModel.pageSize)
    }

    private func setupActivityIndicator() {
        activityIndicator.backgroundColor = .header
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.layer.cornerRadius = 10
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    private func setupViewModelCallback() {
        viewModel.onDataLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }

        viewModel.onErrorOccurred = { [weak self] error in
            DispatchQueue.main.async {
                self?.presentErrorAlert(message: error.localizedDescription)
            }
        }
    }

    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - Extension DataSource & Delegate

extension ArtListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.art.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? ArtHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }

            headerView.backgroundColor = .header
            headerView.setupHeaderCell(with: viewModel.culture)
            headerView.cultureDidChangeCallback = { [weak self] culture in
                self?.handleCultureChange(culture)
            }
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArtCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(with: viewModel.art[indexPath.row])
        return cell
    }
}

extension ArtListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 20, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.size.width - 20, height: 100)
    }
}

extension ArtListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = ArtDetailViewModel(art: viewModel.art[indexPath.row])
        let detailVC = ArtDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ArtListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if !viewModel.isLoading {
                viewModel.pageSize += 10
                viewModel.loadData(with: viewModel.culture, pageSize: viewModel.pageSize)
            }
        }
    }
}
