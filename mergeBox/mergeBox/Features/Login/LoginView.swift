//
//  LoginView.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/10/21.
//

import SwiftUI
import Playgrounds

struct LoginView: View {
    @State private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 78) {
                logo
                VStack (spacing: 50) {
                    VStack(spacing: 14) {
                        userIDTextField
                        passwordTextField
                        loginButton
                    }
                    .padding(.horizontal, 50)
                    orBorder
                    googleLoginButton
                        .padding(.horizontal, 50)
                    resisterButton
                }
            }
        }
    }
}

private extension LoginView {
    // 背景色
    var background: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.Login.Colors.background1, .Login.Colors.background2]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    // ロゴ
    var logo: some View {
        Image(.Login.Images.logo)
            .resizable()
            .frame(width: 235, height: 97)
    }
}

private extension LoginView {
    // ユーザーIDのテキストフィールド
    var userIDTextField: some View {
        ZStack(alignment: .leading) {
            if viewModel.id.isEmpty {
                Text("ユーザーID")
                    .foregroundStyle(.white)
                    .padding()
            }
            TextField("", text: $viewModel.id)
                .textFieldStyle(
                    .customTextField
                )
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
            
        }
    }
    // パスワードテキストフィールド
    var passwordTextField: some View {
        ZStack(alignment: .leading) {
            if viewModel.password.isEmpty {
                Text("パスワード")
                    .foregroundStyle(.white)
                    .padding()
            }
            TextField("", text: $viewModel.password)
                .textFieldStyle(
                    .customTextField
                )
        }
    }
    // ログインボタン
    var loginButton: some View {
        Button("ログイン") {
            
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

private extension LoginView {
    // ---または----- の線
    var orBorder: some View {
        HStack(spacing: 20) {
            border
            Text("または")
                .foregroundStyle(.white)
            border
        }
    }
    var border: some View {
        Rectangle()
            .frame(width: 130, height: 1)
            .foregroundStyle(.white)
    }
    
    // googleのやつ
    var googleLoginButton: some View {
        Button(action: {
            
        }) {
            HStack {
                Image(.Login.Images.googleIcon)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Googleログイン")
                    .foregroundStyle(.black)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .background(.white)
        .clipShape(Capsule())
    }
    
    var resisterButton: some View {
        HStack {
            Text("アカウントが未作成ですか？")
            Button("アカウントを作成") {
                
            }
            .bold()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    LoginView()
}
