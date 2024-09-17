//
//  HttpClient.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import Foundation
import Foundation

class HttpClient {
    
    // Shared instance (Singleton pattern) - optional but useful for common usage
    static let shared = HttpClient()
    
    // Function to perform GET requests
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, HttpClientError>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }
    
    // Function to perform POST requests
    func post<T: Codable, U: Codable>(url: URL, body: T, completion: @escaping (Result<U, HttpClientError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch let encodingError {
            completion(.failure(.decodingError(encodingError)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(U.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }
}
