//
//  LoginView.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = LoginViewModel()
        
    @State private var isRegistering = false
    
    private func handleAuthentication() {
        print("Handle Authentication called")
        viewModel.errorMessage = nil
        if isRegistering {
            registerUser()
        } else {
            loginUser()
        }
    }
    
    private func registerUser() {
        print("Register user called")
    }
    
    private func loginUser() {
        print("Login user called")
        viewModel.login(appState: appState)
    }
    
    private var isFormValid: Bool {
        !viewModel.username.isEmpty && !viewModel.password.isEmpty
    }
    
    var body: some View {
        VStack {
            Text(isRegistering ? "Register" : "Login")
                .font(.headline)
                .padding()
            
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            Button(isRegistering ? "Register" : "Login") {
                handleAuthentication()
            }
            .disabled(!isFormValid)
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button(isRegistering ? "Back to Login" : "Go to Register") {
                isRegistering.toggle()
            }
            .buttonStyle(.link)
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
