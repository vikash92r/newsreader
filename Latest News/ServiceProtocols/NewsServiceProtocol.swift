//
//  ServiceProtocols.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchArticles(topic: String?, category: Category?, page: Int, pageSize: Int, completion: @escaping (Result<[Article], HttpClientError>) -> Void)
}

