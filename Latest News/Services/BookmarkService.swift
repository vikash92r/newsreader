//
//  BookmarkService.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation


// The bookmarks array acts as an in-memory store for bookmarked articles. In a real application, this could be backed by API calls.
class BookmarkService: BookmarkServiceProtocol {
    private var bookmarks: [Article] = []
    
    func saveBookmark(_ article: Article) {
        if !bookmarks.contains(where: { $0.id == article.id }) {
            bookmarks.append(article)
        }
    }
    
    func removeBookmark(_ article: Article) {
        bookmarks.removeAll { $0.id == article.id }
    }
    
    func getBookmarks() -> [Article] {
        return bookmarks
    }
}
