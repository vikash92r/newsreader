//
//  NewsViewModelTests.swift
//  Latest NewsTests
//
//  Created by Vikash Kumar on 17/09/24.
//

import XCTest
@testable import Latest_News

final class NewsViewModelTests: XCTestCase {
    
    var viewModel: NewsViewModel!
    var mockNewsService: MockNewsService!
    var mockBookmarkService: MockBookmarkService!
    
    override func setUp() {
        super.setUp()
        
        // Initialize mock services
        mockNewsService = MockNewsService()
        mockBookmarkService = MockBookmarkService()
        
        // Initialize ViewModel with mock services
        viewModel = NewsViewModel(newsService: mockNewsService, bookmarkService: mockBookmarkService)
    }
    
    func testFetchArticlesSuccess() {
         // Load the sample JSON data
         guard let articles = loadSampleArticles() else {
             XCTFail("Failed to load sample articles")
             return
         }
         
         // Assign mock data as a success result to the mock service
         mockNewsService.result = .success(articles)
         
         // Create an expectation for the async fetchArticles call
         let expectation = self.expectation(description: "Fetching articles")
         
         // Call the ViewModel's fetchArticles method
         viewModel.fetchArticles()
         
         // Wait for async callback
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
             // Notify that we are done waiting
             expectation.fulfill()
         }
         
         // Wait for the expectation to be fulfilled
         waitForExpectations(timeout: 1.0, handler: nil)
         
         // Assert that the ViewModel's articles are correctly populated
         XCTAssertEqual(viewModel.articles.count, articles.count, "ViewModel should have \(articles.count) articles")
        XCTAssertEqual(viewModel.articles.first?.title, articles.first?.title)
     }
     
     func testFetchArticlesFailure() {
         // Simulate an error result from the mock service
         mockNewsService.result = .failure(HttpClientError.requestFailed)
         
         // Create an expectation for the async fetchArticles call
         let expectation = self.expectation(description: "Fetching articles failed")
         
         // Call the ViewModel's fetchArticles method
         viewModel.fetchArticles()
         
         // Wait for async callback
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
             // Notify that we are done waiting
             expectation.fulfill()
         }
         
         // Wait for the expectation to be fulfilled
         waitForExpectations(timeout: 1.0, handler: nil)
         
         // Assert that an error message is set
         XCTAssertNotNil(viewModel.errorMessage, "ViewModel should have an error message")
         XCTAssertEqual(viewModel.errorMessage, "Error: Request failed")
     }

    
    func testToggleBookmark() {
        // Load the sample JSON data
        guard let articles = loadSampleArticles() else {
            XCTFail("Failed to load sample articles")
            return
        }
        
        // Set the ViewModel's articles
        viewModel.articles = articles
        
        // Select the first article to toggle its bookmark status
        var articleToBookmark = viewModel.articles.first!
        
        // Assert the article is not bookmarked initially
        XCTAssertFalse(articleToBookmark.isBookmarked, "Article should not be bookmarked initially")
        
        // Simulate that the article's bookmark status has been updated in the view model
        articleToBookmark.isBookmarked.toggle()
        
        // Toggle the bookmark to add it
        viewModel.toggleBookmark(for: articleToBookmark)
        
        // Assert that the article is now bookmarked in the mock bookmark service
        XCTAssertTrue(mockBookmarkService.bookmarks.contains(articleToBookmark), "First article should be bookmarked")
        
        // Simulate that the article's bookmark status has been updated in the view model
        articleToBookmark.isBookmarked.toggle()
        
        // Toggle the bookmark to remove it
        viewModel.toggleBookmark(for: articleToBookmark)
        
        // Assert that the article is now removed from bookmarks in the mock bookmark service
        XCTAssertFalse(mockBookmarkService.bookmarks.contains(articleToBookmark), "First article should be removed from bookmarks")
    }
}
