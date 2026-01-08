//
//  OnboardingViewModel.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/10/23.
//

import Observation
// オンボーディング画面のActionを定義
enum OnboardingViewAction {
    case nextButtonPressed
}

@Observable
class OnboardingViewModel {
    var router: AppRouter = .init()
    var selection = 1
    var isLoading: Bool = false
    // 現在のタブがonboardingValuesと同じなら(最後のtabなら)true
    var isLastPage: Bool { selection == onboardingValues.count }
    // ボタンの文言を決定する計算型プロパティ
    var nextButtonText: String {
        return selection == onboardingValues.count ? "ログイン" : "次へ"
    }
    // オンボーディングで表示する用の要素を配列で保持
    let onboardingValues = [
        LottieCardView(
            animation: .studyAnimation!,
            title: "ようこそ\nただの自己満アプリmergeBoxへ",
            subtitle: "ほんまにただ自分が実装してみたい機能を\n詰め込んだアプリです",
            tag: 1
        ),
        LottieCardView(
            animation: .challengeAnimation!,
            title: "やりたいことが思いついたら即チャレンジ",
            subtitle: "「こんなの作れたら面白そう！」を\nそのまま実現できる場所",
            tag: 2
        ),
        LottieCardView(
            animation: .loginAnimation!,
            title: "さあ、始めよう！",
            subtitle: "ガチの自己満アプリを始めよう！\n下のボタンを押してログインしよう！",
            tag: 3
        )
    ]
    // Buttonのactionの処理を定義
    func handle(_ action: OnboardingViewAction) {
        switch action {
        case .nextButtonPressed:
            print("isLastPage:" + isLastPage.description)
            // もしオンボーディングのTabViewが最後のページ未満なら+=1をする
            if isLastPage {
                router.navigate(to: .login)
            } else {
                selection += 1
            }
        }
    }
}
