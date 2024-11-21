//
//  ContentView.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showLoginModal = true
    
    var body: some View {
        ZStack {
            NavigationSplitView {
                SidebarView()
            } detail: {
                VStack {
                    Text(appState.authToken ?? "Unknown User")
                        .font(.caption)
                        .padding()
                    Text(appState.userId?.uuidString ?? "Unknown UUID")
                }
            }
            .sheet(isPresented: .constant(!appState.isLoggedIn)) {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(AppState())
}
