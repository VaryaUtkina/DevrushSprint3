//
//  CustomButtonView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 05.02.2025.
//

import SwiftUI

struct CustomButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .font(.largeTitle.bold())
        .frame(width: 300, height: 100)
        .background(.darkBlue ?? .blue)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: 40))
    }
}
