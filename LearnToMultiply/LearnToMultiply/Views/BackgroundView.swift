//
//  BackgroundView.swift
//  LearnToMultiply
//
//  Created by Варвара Уткина on 05.02.2025.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.screenBlue ?? .white, .darkBlue ?? .green], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}
