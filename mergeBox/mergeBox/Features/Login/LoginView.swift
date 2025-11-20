//
//  LoginView.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/10/21.
//

import SwiftUI

struct LoginView: View {
    @State private var id = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 78) {
                Image(.Login.Images.logo)
                    .resizable()
                    .frame(width: 235, height: 97)
                VStack(spacing: 14) {
                    TextField("Email", text: $id)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("ログイン"){
                        
                    }
                    .buttonStyle(
                        .customButtonStyle(
                            foregroundColor: Color(.Login.Colors.background1),
                            backgroundColor: .white,
                            fontSize: .headline,
                            height: 52,
                            width: 293
                        )
                    )
                }
            }
        }
    }
    // 背景色
    var background: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.Login.Colors.background1, .Login.Colors.background2]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    LoginView()
}
