//
//  DevidedRectangleView.swift
//  MoonShot
//
//  Created by Варвара Уткина on 09.02.2025.
//

import SwiftUI

struct DevidedRectangleView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    DevidedRectangleView()
}
