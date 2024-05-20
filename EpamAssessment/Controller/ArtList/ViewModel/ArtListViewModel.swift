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
    var isLoading: Bool = true {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    var onLoadingStateChanged: ((Bool) -> Void)?

    // MARK: - Private

    private let service: any ArtService

    // MARK: - Init

    init(service: any ArtService) {
        self.service = service
    }

    // MARK: - Request methods

    func loadData(with culture: Culture, pageSize: Int) {
        isLoading = true
        Task {
            do {
                let artData = try await service.retrieveArt(pageSize: pageSize, culture: culture)
                self.art = artData.artObjects
                isLoading = false
            } catch {
                isLoading = false
                print("An error occurred: \(error.localizedDescription)")
                throw InterfaceError.unknown(message: error.localizedDescription)
            }
        }
    }
}
