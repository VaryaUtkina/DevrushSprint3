//
//  ContentView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 04.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplyTable = 12
    @State private var numberOfQuestion = 5
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                VStack(spacing: 20) {
                    Text("Which multiplication tables you want to practice?")
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                    Stepper("Up to... \(multiplyTable)", value: $multiplyTable, in: 2...12, step: 1)
                    
                    Text("How many questions you want to be asked?")
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                    Picker("", selection: $numberOfQuestion) {
                        ForEach([5, 10, 20], id: \.self) { number in
                            Text("\(number) questions")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 16)
                
                Button("PLAY") {
                    
                }
                .font(.largeTitle.bold())
                .frame(width: 300, height: 100)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 40))
            }
            .frame(width: .infinity, height: 400)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 70))
        }
    }
}

#Preview {
    ContentView()
}
