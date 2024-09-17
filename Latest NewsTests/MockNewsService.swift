//
//  MockNewsService.swift
//  Latest NewsTests
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation
@testable import Latest_News

class MockNewsService: NewsServiceProtocol {
    var result: Result<[Article], HttpClientError>?
    func fetchArticles(topic: String?, page: Int, pageSize: Int, completion: @escaping (Result<[Article], HttpClientError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
