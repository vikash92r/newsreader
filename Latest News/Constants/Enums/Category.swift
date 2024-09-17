//
//  Category.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation

enum Category: String, CaseIterable {
    case health = "health"
    case sports = "sports"
    case technology = "technology"
    case business = "business"
    case entertainment = "entertainment"
    case science = "science"
    case politics = "politics"

    var description: String {
        switch self {
        case .health:
            return "Health"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .science:
            return "Science"
        case .politics:
            return "Politics"
        }
    }
}
