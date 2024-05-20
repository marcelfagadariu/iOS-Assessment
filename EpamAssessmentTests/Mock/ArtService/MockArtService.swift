//
//  MockArtService.swift
//  EpamAssessmentTests
//
//  Created by Marcel on 19.05.2024.
//

@testable import EpamAssessment

class MockArtService: ArtService {
    
    var culture: String?
    var hasBeenCalled = false
    var shouldThrowError = false

    func retrieveArt(pageSize: Int, culture: Culture) async throws -> ArtObject {
        self.hasBeenCalled = true
        if shouldThrowError { throw InterfaceError.internalError }
        self.culture = culture.rawValue
        return .init(artObjects: ArtObject.mock)
    }
}
