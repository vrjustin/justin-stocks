//
//  APIManager.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import Foundation
import JustinStocksSharedDTO

class APIManager {
    
    static let shared = APIManager()
    
    private var baseURL: URL
    
    private init() {
        #if DEBUG
        self.baseURL = URL(string: "http://127.0.0.1:8080/api")!
        #else
        self.baseURL = URL(string: "http://127.0.0.1:8080/api")!
        #endif
    }
    
    func setBaseURL(_ url: String) {
        guard let newURL = URL(string: url) else {
            print("Invalid base URL")
            return
        }
        self.baseURL = newURL
    }
    
    func makeRequest<T: Codable>(
            endpoint: String,
            method: String = "GET",
            headers: [String: String]? = nil,
            body: Data? = nil,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            let url = baseURL.appendingPathComponent(endpoint)

            var request = URLRequest(url: url)
            request.httpMethod = method

            // Add default headers
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Add custom headers
            if let headers = headers {
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }

            // Add body
            if let body = body {
                request.httpBody = body
            }

            // Perform the network request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received."])))
                    }
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
}

extension APIManager {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponseDTO, Error>) -> Void) {
        let endpoint = "login"
        let body = [
            "username": username,
            "password": password
        ]

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(NSError(domain: "APIManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request body."])))
            return
        }

        makeRequest(endpoint: endpoint, method: "POST", body: bodyData, completion: completion)
    }

    func register(username: String, password: String, completion: @escaping (Result<RegisterResponseDTO, Error>) -> Void) {
        let endpoint = "register"
        let body = [
            "username": username,
            "password": password
        ]

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            completion(.failure(NSError(domain: "APIManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request body."])))
            return
        }

        makeRequest(endpoint: endpoint, method: "POST", body: bodyData, completion: completion)
    }
}
