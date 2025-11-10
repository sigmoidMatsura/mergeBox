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
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
