//
//  ArtListViewController.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit

class ArtListViewController: UIViewController {

    // MARK: - Properties

    let viewModel: ArtListViewModel
    private var collectionView: UICollectionView!
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    // MARK: - View did Load

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        viewModel.loadData(with: viewModel.culture, pageSize: viewModel.pageSize)
        setupNavigation()
        reloadCollectionView()
        setupActivityIndicator()
        setupViewModelCallbacks()
    }

    // MARK: - Init

    init(viewModel: ArtListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

    private func reloadCollectionView() {
        viewModel.onDataLoaded = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func handleCultureChange(_ culture: Culture) {
        viewModel.pageSize = 10
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

    private func setupViewModelCallbacks() {
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
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
        let detailVC = ArtDetailViewController(art: viewModel.art[indexPath.row])
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

