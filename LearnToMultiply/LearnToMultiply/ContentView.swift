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
    
    @State private var isShowingPlayView = false
    @State private var showContent = false
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 20) {
                Spacer()
                
                if showContent {
                    Image("zebra")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeIn(duration: 0.6), value: showContent)
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
                }
                
                if showContent {
                    VStack(spacing: 50) {
                        VStack(spacing: 20) {
                            CustomQuestionView(text: "Which multiplication tables you want to practice?")
                            
                            Stepper("Up to... \(multiplyTable)", value: $multiplyTable, in: 2...12, step: 1)
                                .foregroundStyle(.darkBlue ?? .blue)
                                .bold()
                            
                            CustomQuestionView(text: "How many questions you want to be asked?")
                            
                            Picker("", selection: $numberOfQuestion) {
                                ForEach([5, 10, 20], id: \.self) { number in
                                    Text("\(number) questions")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal, 16)
                        
                        CustomButtonView(title: "PLAY") {
                            withAnimation {
                                animationAmount += 360
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                isShowingPlayView = true
                            }
                        }
                    }
                    .padding(16)
                    .frame(height: 450)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 70))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeIn(duration: 0.8), value: showContent)
                }
                
                Spacer()
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isShowingPlayView) {
            PlayView(
                multiplyTable: $multiplyTable,
                numberOfQuestion: $numberOfQuestion,
                onDismiss: {
                    isShowingPlayView = false
                }
            )
        }
        .onAppear {
            withAnimation {
                showContent = true
            }
        }
    }
}

#Preview {
    ContentView()
}
