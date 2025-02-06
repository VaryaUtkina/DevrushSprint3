//
//  PlayView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 04.02.2025.
//

import SwiftUI

import SwiftUI

struct PlayView: View {
    @Binding var multiplyTable: Int
    @Binding var numberOfQuestion: Int
    var onDismiss: () -> Void
    
    @State private var table: [Int] = []
    @State private var numberOne = 0
    @State private var numberTwo = 0
    
    @State private var question = 0
    @State private var answer = ""
    @State private var score = 0
    
    @State private var showingAlert = false
    @State private var animal = Animals.allCases.randomElement() ?? .bear
    
    @State private var showContent = false
    @State private var animationAmount = 0.0
    @State private var frameColor: Color = .clear
    
    @FocusState private var isTextFocused: Bool
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 25) {
                Text("Score: \(score)")
                    .foregroundStyle(.darkBlue?.opacity(0.5) ?? .blue)
                    .font(.title.bold())
                
                if showContent {
                    VStack {
                        HStack {
                            Image(animal.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
                            
                            Spacer()
                            
                            CustomQuestionView(text: "What is \(numberOne) x \(numberTwo)?")
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    .background(frameColor != .clear ? frameColor : Color(.systemBackground).opacity(0.3))
                    .clipShape(.rect(cornerRadius: 70))
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeIn(duration: 0.6), value: showContent)
                }
                
                if showContent {
                    VStack(spacing: 30) {
                        TextField("Your answer", text: $answer)
                            .textFieldStyle(.roundedBorder)
                            .font(.title)
                            .frame(width: 250)
                            .keyboardType(.numberPad)
                            .focused($isTextFocused)
                        
                        CustomButtonView(title: "NEXT") {
                            withAnimation {
                                animationAmount += 360
                            }
                            checkAnswer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .background(frameColor != .clear ? frameColor : Color(.systemBackground).opacity(0.3))
                    .clipShape(.rect(cornerRadius: 70))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeIn(duration: 0.8), value: showContent)
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            table = Array(2...multiplyTable)
            getNumbers()
            
            withAnimation {
                showContent = true
            }
        }
        .alert("GAME OVER", isPresented: $showingAlert) {
            Button("OK") {
                withAnimation {
                    onDismiss()
                }
            }
            Button("Try again") {
                resetGame()
            }
        } message: {
            Text("Your score: \(score) / \(numberOfQuestion)")
        }

    }
    
    func getNumbers() {
        numberOne = table.randomElement() ?? 0
        numberTwo = (2...12).randomElement() ?? 0
    }
    
    func checkAnswer() {
        isTextFocused = false
        guard let intNumber = Int(answer) else { return }
        if intNumber == numberOne * numberTwo {
            score += 1
            withAnimation {
                frameColor = .green.opacity(0.6)
            }
        } else {
            withAnimation {
                frameColor = .red.opacity(0.6)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                frameColor = .clear
            }
        }

        answer = ""
        nextQuestion()
    }
    
    func nextQuestion() {
        question += 1
        if question < numberOfQuestion {
            getNumbers()
            animal = Animals.allCases.randomElement() ?? .bear
        } else {
            showingAlert = true
        }
    }
    
    func resetGame() {
        question = 0
        score = 0
        getNumbers()
        withAnimation(.snappy) {
            animal = Animals.allCases.randomElement() ?? .bear
        }
    }
}

#Preview {
    PlayView(multiplyTable: .constant(12), numberOfQuestion: .constant(5), onDismiss: {})
}
