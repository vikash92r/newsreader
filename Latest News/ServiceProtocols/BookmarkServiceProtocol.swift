//
//  BookmarkServiceProtocol.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation


protocol BookmarkServiceProtocol {
    func saveBookmark(_ article: Article)
    func removeBookmark(_ article: Article)
    func getBookmarks() -> [Article]
}

