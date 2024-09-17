//
//  AppHelpers.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation


// Helper function to load the sample JSON file
func loadSampleArticles() -> [Article]? {
    
    guard let url = Bundle.main.url(forResource: "sample_articles", withExtension: "json") else {
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(ApiResponse.self, from: data)
        return response.results
    } catch {
        return nil
    }
}
