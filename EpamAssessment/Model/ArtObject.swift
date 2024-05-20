//
//  ArtObject.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

struct ArtObject: Decodable {
    let artObjects: [Art]
}

extension ArtObject {
    static let mock = [
        Art(
            id: "1",
            links: .init(web: "https://example.com/art1"),
            title: "Title 1",
            hasImage: true,
            longTitle: "Long title 1",
            webImage: .init(
                url: "https://web1"
            ),
            headerImage: .init(
                url: "https://header1"
            ),
            productionPlaces: ["Place 1"]
        ),
        Art(
            id: "2",
            links: .init(web: "https://example.com/art2"),
            title: "Title 2",
            hasImage: false,
            longTitle: "Long title 2",
            webImage: .init(
                url: "https://web2"
            ),
            headerImage: .init(
                url: "https://header2"
            ),
            productionPlaces: ["Place 2"]
        ),
        Art(
            id: "3",
            links: .init(web: "https://example.com/art3"),
            title: "Title 3",
            hasImage: true,
            longTitle: "Long title 3",
            webImage: .init(
                url: "https://web3"
            ),
            headerImage: .init(
                url: "https://header3"
            ),
            productionPlaces: ["Place 3"]
        )
    ]
}
