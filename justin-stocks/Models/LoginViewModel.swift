//
//  LoginViewModel.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func login(appState: AppState) {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        isLoading = true
        errorMessage = nil
        
        // Simulate API Call
        // TODO: call our backend via our api service.
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                appState.authToken = "fakeToken123"
                appState.isLoggedIn = true
                self.isLoading = false
            }
        }
    }
}
