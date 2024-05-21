//
//  ArtListViewModel.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import Foundation

final class ArtListViewModel {

    // MARK: - Properties

    var culture: Culture = .nl
    var art: [Art] = [] {
        didSet {
            onDataLoaded?()
        }
    }
    var onDataLoaded: (() -> Void)?
    var pageSize = 10
    var isLoading: Bool = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onErrorOccurred: ((InterfaceError) -> Void)?

    // MARK: - Private

    private let service: any ArtService

    // MARK: - Init

    init(service: any ArtService) {
        self.service = service
    }

    // MARK: - Request methods

    func loadData(with culture: Culture, pageSize: Int) {
        guard !isLoading else { return }
        isLoading = true
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let artData = try await service.retrieveArt(pageSize: pageSize, culture: culture)
                self.art.append(contentsOf: artData.artObjects)
                self.isLoading = false
            } catch {
                self.isLoading = false
                print("An error occurred: \(error.localizedDescription)")
                self.onErrorOccurred?(InterfaceError.unknown(message: error.localizedDescription))
            }
        }
    }
}
