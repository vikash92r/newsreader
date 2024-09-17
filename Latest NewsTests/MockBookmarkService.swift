//
//  MockBookmarkService.swift
//  Latest NewsTests
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation
@testable import Latest_News

class MockBookmarkService: BookmarkServiceProtocol {
    var bookmarks: [Article] = []

    func getBookmarks() -> [Article] {
        return bookmarks
    }

    func saveBookmark(_ article: Article) {
        if !bookmarks.contains(where: { $0.id == article.id }) {
            bookmarks.append(article)
        }
    }

    func removeBookmark(_ article: Article) {
        bookmarks.removeAll(where: { $0.id == article.id })
    }
}
