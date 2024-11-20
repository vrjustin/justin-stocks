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
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var showLoginModal = true

    var body: some View {
        ZStack {
            NavigationSplitView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            } detail: {
                Text("Select an item")
            }
            .sheet(isPresented: .constant(!appState.isLoggedIn)) {
                LoginView()
            }
        }
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
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
