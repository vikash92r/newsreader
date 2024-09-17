//
//  NewsViewModel.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var hasMoreArticles = true // Flag to indicate if more articles can be fetched
    @Published var errorMessage: String? // Store error messages

    private let newsService: NewsServiceProtocol
    private let bookmarkService: BookmarkServiceProtocol
    private var currentPage = 1 // Tracks the current page for pagination
    private let articlesPerPage = 20 // Number of articles per page

    init(newsService: NewsServiceProtocol = NewsService(), bookmarkService: BookmarkServiceProtocol = BookmarkService()) {
        self.newsService = newsService
        self.bookmarkService = bookmarkService
    }

    func resetPage() {
        currentPage = 1
        hasMoreArticles = true
        articles.removeAll()
    }
    
    func fetchArticles(topic: String? = nil, category: Category? = nil) {

        guard !isLoading && hasMoreArticles else { return }
        isLoading = true
        errorMessage = nil // Reset error message before making the request
        newsService.fetchArticles(topic: topic, category: category, page: currentPage, pageSize: articlesPerPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newArticles):
                    if newArticles.count < self?.articlesPerPage ?? 20 {
                        self?.hasMoreArticles = false // No more articles if the batch is smaller than 20
                    }
                    self?.articles.append(contentsOf: newArticles)
                    self?.currentPage += 1 // Increment the page number for the next fetch
                case .failure(let error):
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    func toggleBookmark(for article: Article) {
        if article.isBookmarked {
            bookmarkService.saveBookmark(article)
        } else {
            bookmarkService.removeBookmark(article)
        }
    }
    
    func getBookmarks() -> [Article] {
        return bookmarkService.getBookmarks()
    }
}
