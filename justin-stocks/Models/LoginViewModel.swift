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
    @Published var isRegistering = false
    @Published var errorMessage: String?
        
    func clearFields() {
        username = ""
        password = ""
    }
        
    func login(appState: AppState) {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        isLoading = true
        errorMessage = nil
                
        // API Call
        APIManager.shared.login(username: username, password: password) { result in
            switch result {
            case .success(let response):
                if response.error {
                    print("Login failed: \(response.reason ?? "Unknown error")")
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.errorMessage = response.reason
                    }
                } else {
                    print("Login successful! Token: \(response.token ?? "")")
                    self.clearFields()
                    DispatchQueue.main.async {
                        appState.saveToken(response.token!)
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func register() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required"
            return
        }
        isLoading = true
        errorMessage = nil
        
        APIManager.shared.register(username: username, password: password) { result in
            switch result {
            case .success(let response):
                if response.error {
                    print("Registration failed: \(response.reason ?? "Unknown error")")
                } else {
                    print("Registration successful!")
                    self.clearFields()
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isRegistering = false
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}
