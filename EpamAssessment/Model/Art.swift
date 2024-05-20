//
//  Art.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

struct Art: Decodable {
    let id: String
    let links: Links
    let title: String
    let hasImage: Bool
    let longTitle: String
    let webImage, headerImage: ArtImage
    let productionPlaces: [String]
}
