//
//  PlayView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 04.02.2025.
//

import SwiftUI

import SwiftUI

struct PlayView: View {
    @State private var multiplyTable = 12
    @State private var numberOfQuestion = 5
    
    @State private var question = 0
    @State private var table: [Int] = []
    @State private var numberOne = 0
    @State private var numberTwo = 0
    @State private var answer = ""
    @State private var score = 0
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 50) {
                    VStack(spacing: 20) {
                        Text("What is \(numberOne) x \(numberTwo)?")
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                        
                        TextField("Enter your answer", text: $answer)
                            .textFieldStyle(.roundedBorder)
                            .font(.title2)
                            .frame(width: 200)
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal, 16)
                    
                    Button("NEXT") {
                        checkAnswer()
                    }
                    .font(.largeTitle.bold())
                    .frame(width: 300, height: 100)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 40))
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 70))
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.gray.opacity(0.5))
                    .font(.largeTitle.bold())
            }
        }
        .onAppear {
            table = Array(2...multiplyTable)
            getNumbers()
        }
        .alert("GAME OVER", isPresented: $showingAlert) { } message: {
            Text("Your score: \(score) / \(numberOfQuestion)")
        }

    }
    
    func getNumbers() {
        numberOne = table.randomElement() ?? 0
        numberTwo = (2...12).randomElement() ?? 0
    }
    
    func checkAnswer() {
        guard let intNumber = Int(answer) else { return }
        if intNumber == numberOne * numberTwo {
            score += 1
        }
        answer = ""
        nextQuestion()
    }
    
    func nextQuestion() {
        question += 1
        if question < numberOfQuestion {
            getNumbers()
        } else {
            showingAlert = true
        }
    }
}

#Preview {
    PlayView()
}
