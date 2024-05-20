//
//  DefaultArtService.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import Foundation.NSURL

final class DefaultArtService {

    // MARK: - Private

    private let session: Session
    private let api: API

    // MARK: - Init

    init(session: Session = Session(), api: API = .dev) {
        self.session = session
        self.api = api
    }
}

extension DefaultArtService: ArtService {
    func retrieveArt(pageSize: Int, culture: Culture) async throws -> ArtObject {
        var urlComponents = URLComponents(string: api.rawValue)
        urlComponents?.path += "\(culture.rawValue)/collection"
        let additionalQueryItems = [
            URLQueryItem(name: "key", value: api.apiKey),
            URLQueryItem(name: "ps", value: "\(pageSize)")
        ]
        urlComponents?.queryItems = additionalQueryItems
        guard let url = urlComponents?.url else { throw InterfaceError.networkError }
        return try await session.get(
            url: url,
            headers: [:]
        )
    }
}
