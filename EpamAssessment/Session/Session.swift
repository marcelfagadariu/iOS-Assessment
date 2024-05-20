//
//  Session.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import SwiftAsyncNetworking
import Foundation

final class Session: SwiftAsyncNetworking {

    // MARK: - Init

    init() {
        super.init(decoder: .iso8601JSONDecoder)
    }

    override func request(url: URL, method: RestMethod, headers: [String : String]) async throws -> URLRequest {
        var headers = headers
        headers["content-type"] = "application/json"
        return try await super.request(url: url, method: method, headers: headers)
    }
}
