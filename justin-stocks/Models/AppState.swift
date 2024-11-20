//
//  AppState.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var authToken: String? = nil
    @Published var userId: UUID? = nil
    
    private let tokenKey = "authToken"
    
    init() {
        if let savedToken = KeychainHelper.retrieve(key: tokenKey) {
            authToken = savedToken
            isLoggedIn = true
        }
    }
    
    func saveToken(_ token: String) {
        authToken = token
        isLoggedIn = true
        //TODO: decode the token to get the userID embedded in it.
        KeychainHelper.save(key: tokenKey, value: token)
    }
    
    func clearToken() {
        authToken = nil
        isLoggedIn = false
        userId = nil
        KeychainHelper.delete(key: tokenKey)
    }
}
