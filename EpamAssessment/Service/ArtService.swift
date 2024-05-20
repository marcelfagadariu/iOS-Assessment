//
//  ArtService.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

protocol ArtService {
    func retrieveArt(pageSize: Int, culture: Culture) async throws -> ArtObject
}
