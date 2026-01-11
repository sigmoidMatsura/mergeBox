# SwiftUI Routerベース画面遷移設計

このREADMEは、SwiftUIにおける **Routerパターンを用いた画面遷移設計** のサンプル実装と、その役割を説明するためのドキュメントです。  
Push / Sheet / FullScreen / Tab を **型安全かつ責務分離** して管理することを目的としています。

---

## 全体構成

```
App
├─ AppRouter.swift
├─ MainTabView.swift
Shared
├─ Router.swift
Features
├─ Home
│  ├─ HomeRoute.swift
│  ├─ HomeViewModel.swift
│  └─ HomeView.swift
```

---

## 1. Shared/Router.swift  
### 画面遷移のコアとなる共通Router

### 目的
- NavigationStack / Sheet / FullScreen を一元管理
- 遷移先を enum + Generics で型安全に制御
- ViewModel から View の実装詳細を隠蔽

### ポイント
- `AppRouteProtocol`  
  遷移先 enum が必ず準拠するプロトコル
- `Router<T>`  
  機能単位で使い回せる汎用Router

```swift
protocol AppRouteProtocol: Hashable, Identifiable {
    var id: String { get }
}

extension AppRouteProtocol {
    var id: String { String(describing: self) }
}
```

```swift
class Router<T: AppRouteProtocol>: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentingSheet: T?
    @Published var presentingFullScreen: T?
}
```

---

## 2. App/AppRouter.swift  
### アプリ全体を統括する親Router

### 役割
- Tabの選択状態を管理
- 各機能Routerを保持
- タブを跨ぐ遷移ロジックを集約

```swift
class AppRouter: ObservableObject {
    @Published var selectedTab: MainTab = .home

    let homeRouter = Router<HomeRoute>()
    let profileRouter = Router<ProfileRoute>()
}
```

### タブ跨ぎ遷移の例

```swift
func switchToProfileAndEdit() {
    selectedTab = .profile
    profileRouter.presentSheet(.editProfile)
}
```

---

## 3. Features/Home/HomeRoute.swift  
### 機能単位の遷移先定義

### ポイント
- Home機能専用の遷移先を enum で定義
- 他機能とは完全に分離

```swift
enum HomeRoute: AppRouteProtocol {
    case detail(id: String)
    case comments
    case settings
}
```

---

## 4. Features/Home/HomeViewModel.swift  
### Routerを操作するViewModel

### 設計意図
- Viewは遷移を直接触らない
- ViewModelがRouterを操作
- テストしやすい構成

```swift
class HomeViewModel: ObservableObject {
    private let router: Router<HomeRoute>

    init(router: Router<HomeRoute>) {
        self.router = router
    }
}
```

### Action駆動の遷移

```swift
func handle(_ action: Action) {
    switch action {
    case .detailButtonTapped(let id):
        router.push(.detail(id: id))

    case .settingsButtonTapped:
        router.presentSheet(.settings)

    case .taskCompleted:
        router.popToRoot()
        router.dismissSheet()
    }
}
```

---

## 5. Features/Home/HomeView.swift  
### ViewModelへRouterをDIするView

### ポイント
- Routerは `EnvironmentObject`
- ViewModel生成時にRouterを注入
- Viewはイベント通知のみ担当

```swift
struct HomeView: View {
    @EnvironmentObject var router: Router<HomeRoute>
    @StateObject var viewModel: HomeViewModel
}
```

---

## 6. App/MainTabView.swift  
### Routerを組み立てるエントリーポイント

### 役割
- Routerの生成とライフサイクル管理
- `.navigationDestination` の集約
- `.sheet` / `.fullScreenCover` の配置

```swift
NavigationStack(path: $appRouter.homeRouter.path) {
    HomeView(router: appRouter.homeRouter)
        .navigationDestination(for: HomeRoute.self) { route in
            switch route {
            case .detail(let id):
                Text("Detail ID: \(id)")
            case .comments:
                Text("Comments View")
            case .settings:
                Text("Settings View")
            }
        }
}
```

---

## この設計のメリット

- ✅ 遷移を enum で型安全に管理
- ✅ View / ViewModel / Router の責務分離
- ✅ 機能単位でRouterを分割可能
- ✅ Tabを跨ぐ遷移も一元管理
- ✅ SwiftUIの思想を壊さず拡張可能

---

## 向いているプロジェクト

- 中〜大規模SwiftUIアプリ
- MVVM構成
- チーム開発
- 画面数が増えやすいアプリ

---

## まとめ

このRouter設計は  
**「画面遷移を状態として扱う」** ことにフォーカスしています。

SwiftUIらしさを保ちつつ、  
UIKitライクな遷移管理の悩みを解消する構成です。
