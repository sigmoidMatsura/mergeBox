//
//  RoundedButtonStyle.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/11/09.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    let fontSize: Font
    let height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(fontSize)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .padding(.horizontal)
            .background(
                configuration.isPressed
                    ? backgroundColor.opacity(0.5)
                    : backgroundColor
            )
            .foregroundStyle(foregroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    Button("Hello") {

    }
    .buttonStyle(
        RoundedButtonStyle(
            foregroundColor: .white,
            backgroundColor: .blue,
            fontSize: .title2,
            height: 44
        )
    )
}
