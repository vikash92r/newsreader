//
//  ApiResponse.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation

// Top-level response model
struct ApiResponse: Decodable {
    let status: String
    let results: [Article]
}
