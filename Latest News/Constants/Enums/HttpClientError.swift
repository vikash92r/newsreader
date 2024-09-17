//
//  HttpClientError.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation

enum HttpClientError: Error {
    case networkError(Error)
    case serverError(statusCode: Int)
    case decodingError(Error)
    case noData
    case unknownError
    case invalidUrl
    case requestFailed

    var localizedDescription: String {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .noData:
            return "No data received from server"
        case .invalidUrl:
            return "Invalid Url"
        case .requestFailed:
            return "Request failed"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}
