//
//  API.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

enum API: String, CaseIterable {

    static var env = API.dev

    case dev = "https://www.rijksmuseum.nl/api/"
    case prod = "https://www.rijksmuseum.nl/prod/" /// Subject of change

    var apiKey: String { "0fiuZFh4" }
}
