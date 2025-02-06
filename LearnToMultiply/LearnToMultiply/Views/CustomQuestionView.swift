//
//  CustomQuestionView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 05.02.2025.
//

import SwiftUI

struct CustomQuestionView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title3.bold())
            .foregroundStyle(.darkBlue ?? .blue)
            .multilineTextAlignment(.center)
            .shadow(radius: 5)
    }
}
