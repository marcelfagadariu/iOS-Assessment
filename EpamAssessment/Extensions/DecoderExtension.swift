//
//  DecoderExtension.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import Foundation

extension JSONDecoder {
    static var iso8601JSONDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601DateFormatter)
        return decoder
    }
}
