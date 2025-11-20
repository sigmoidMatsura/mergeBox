//
//  mergeBoxApp.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/10/16.
//

import SwiftUI

@main
struct mergeBoxApp: App {
    init() {
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
    }
    // userDefaultで保持する
    var isLogin: Bool = false
    // 初期起動かUserdefaultで保持する
    // プロパティラッパーで実装すること
//    var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isLogin {
                LoginView()
            } else {
                OnboardingView()
            }
        }
    }
}
