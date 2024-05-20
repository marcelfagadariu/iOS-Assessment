//
//  MockArtService.swift
//  EpamAssessmentTests
//
//  Created by Marcel on 19.05.2024.
//

@testable import EpamAssessment

class MockArtService: ArtService {
    var countryCode: String?
    var hasBeenCalled = false
    var shouldThrowError = false

    func retrieveArt(page: Int, pageSize: Int, culture: Culture) async throws -> ArtObject {
        if shouldThrowError { throw InterfaceError.internalError }
        self.hasBeenCalled = true
        return .init(artObjects: ArtObject.mock)
    }
}
