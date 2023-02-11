//
//  NetworkError.swift
//  rickmorty
//
//  Created by Alex Rudoi on 10/2/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case responseStatusError(status: Int, message: String)
}

extension NetworkError {
    public var errorDescription: String? {
        switch self {
        case let .responseStatusError(status, message):
            return "Error with status \(status) and message \(message) was thrown"
        }
    }
}
