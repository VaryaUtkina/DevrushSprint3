//
//  ContentView.swift
//  Flag
//
//  Created by Варвара Уткина on 23.01.2025.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct BlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
    }
}

extension Text {
    func applyBlueFont() -> some View {
        modifier(BlueFont())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var finishingGame = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 1
    
    @State private var animationAmount = 0.0
    @State private var selectedFlag: Int? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .applyBlueFont()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                        .opacity(selectedFlag == nil || selectedFlag == number ? 1.0 : 0.25)
                        .animation(.default, value: selectedFlag)
                        .scaleEffect(selectedFlag != nil && selectedFlag != number ? 0.8 : 1.0)
                        .animation(.default, value: selectedFlag)
                        .rotation3DEffect(.degrees(selectedFlag == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $finishingGame) {
            Button("Reset", action: reset)
        } message: {
            Text("Correct answers is \(score)/8")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        
        withAnimation(.spring(duration: 1, bounce: 0.5)) {
            animationAmount += 360
        } completion: {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong! This is flag of \(countries[number])"
            }
            
            showingScore = true
        }
    }
    
    func askQuestion() {
        selectedFlag = nil
        if numberOfQuestions == 8 {
            finishingGame = true
            return
        }
        numberOfQuestions += 1
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        numberOfQuestions = 1
    }
}

#Preview {
    ContentView()
}
