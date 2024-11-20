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
}
