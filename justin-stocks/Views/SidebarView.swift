//
//  SidebarView.swift
//  justin-stocks
//
//  Created by Justin Maronde on 11/21/24.
//

import SwiftUI
import SwiftData

struct SidebarView: View {

    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    private func logout() {
        appState.clearToken()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

    var body: some View {
        VStack {
            if appState.isLoggedIn {
                List {
                    ForEach(1...5, id: \.self) { index in
                        Text("Stock \(index)")
                    }
                }
            }
            Spacer()
            Button(action: {
                logout()
            }, label: {
                Label("Logout", systemImage: "person.crop.circle.badge.xmark")
            })
            .disabled(!appState.isLoggedIn)
            .padding(.bottom, 10)
            
            Text("Version \(Bundle.main.appVersion)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
        }
        .padding()
    }
}

#Preview {
    SidebarView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(AppState())
}
