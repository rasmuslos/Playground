//
//  ContentView.swift
//  Playground
//
//  Created by Rasmus Krämer on 22.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Recipe View", destination: RecipeView())
        }
    }
}

#Preview {
    ContentView()
}
