//
//  NewsService.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation

class NewsService: NewsServiceProtocol {

    private let baseURL: String
    
    init(baseURL: String = BASE_URL) {
        self.baseURL = baseURL
    }
    
    // Code is written to handle pagination but free version of News data API do not support
    func fetchArticles(topic: String?, category: Category?, page: Int, pageSize: Int, completion: @escaping (Result<[Article], HttpClientError>) -> Void) {
        
        
        var urlComponents = URLComponents(string: baseURL)
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "apikey", value: API_KEY))

        // Add optional filters
        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        }
        
        // Add optional filters
        if let topic = topic {
            queryItems.append(URLQueryItem(name: "q", value: topic))
        }
        
                
        // Add pagination parameters
        //       queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        //       queryItems.append(URLQueryItem(name: "limit", value: "\(pageSize)"))
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidUrl))
            return
        }

        HttpClient.shared.get(url: url) { (result: Result<ApiResponse, HttpClientError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                print("Error fetching articles: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        
    }
}
