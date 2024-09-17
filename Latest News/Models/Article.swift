//
//  Article.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation

struct Article: Decodable, Identifiable, Equatable {
    var id: String { articleId } // To conform to Identifiable
    
    let articleId: String
    let title: String
    let summary: String
    let content: String
    let imageUrl: String
    var isBookmarked: Bool = false // Provide a default value

    
    private enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case title
        case summary = "description"
        case content
        case imageUrl = "image_url"
        case isBookmarked
    }
    
    // Custom initializer to handle missing 'isBookmarked' key in JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        articleId = try container.decode(String.self, forKey: .articleId)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        summary = try container.decodeIfPresent(String.self, forKey: .summary)  ?? ""
        content = try container.decodeIfPresent(String.self, forKey: .content)  ?? ""
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)  ?? ""
        isBookmarked = try container.decodeIfPresent(Bool.self, forKey: .isBookmarked) ?? false
    }
    
    
    // Conform to Equatable by defining equality
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.articleId == rhs.articleId
    }
}

