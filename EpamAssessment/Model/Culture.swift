//
//  Culture.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

enum Culture: String, CaseIterable {
    case nl = "nl"
    case en = "en"

    var displayName: String {
        switch self {
        case .nl:
            return "Netherlands"
        case .en:
            return "England"
        }
    }
}
