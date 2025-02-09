//
//  ContentView.swift
//  MoonShot
//
//  Created by Варвара Уткина on 07.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayoutView(astronauts: astronauts, missions: missions)
                } else {
                    ListLayoutView(astronauts: astronauts, missions: missions)
                }
            }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button("", systemImage: showingGrid ? "list.bullet" : "rectangle.grid.2x2") {
                        showingGrid.toggle()
                    }
                    .foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    ContentView()
}
