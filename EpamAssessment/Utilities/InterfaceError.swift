//
//  InterfaceError.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import Foundation

public enum InterfaceError: Error, LocalizedError, Identifiable {
    case internalError
    case networkError
    case specialized(error: LocalizedError)
    case unknown(message: String)
    case custom(title: String, message: String)

    public var id: String {
        switch self {
        case .internalError: return "invalid_error"
        case .networkError: return "network_error"
        case .specialized: return "specialized_error"
        case .unknown: return "unknown_error"
        case .custom: return "custom_error"
        }
    }

    public var errorDescription: String? {
        switch self {
        case .internalError:
            return "A networking error occured!"
        case .networkError:
            return "Please check your connection and try again"
        case .specialized(error: let error):
            return error.errorDescription
        case .unknown(message: _):
            return "An internal error occured!"
        case .custom(title: let title, message: _):
            return title
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .internalError:
            return "Please try again later"
        case .networkError:
            return "Please check your connection and try again"
        case .specialized(error: let error):
            return error.recoverySuggestion
        case .unknown(message: let message):
            return message
        case .custom(title: _, message: let message):
            return message
        }
    }
}
