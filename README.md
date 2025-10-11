# 🏗️ Clean Architecture Template for SwiftUI

このプロジェクトは **SwiftUI** をベースに、  
**クリーンアーキテクチャ（Clean Architecture）** の思想を取り入れた個人開発向け構成を採用しています。  
Infra層を省略し、**Data層でAPIやDBアクセスを行う軽量構成** です。  

---

## 🧠 採用アーキテクチャ

### 🎯 アーキテクチャパターン  
**Clean Architecture（軽量版）**

### 🎨 UIフレームワーク  
**SwiftUI**

### 💉 依存性注入（DI）  
**独自DIコンテナ（AppDIContainer.swift）**

DIを使い、  
- ViewModel ⇄ UseCase  
- UseCase ⇄ Repository  
- Repository ⇄ DataSource  
を疎結合にしています。

---

## 🧱 フォルダ構成

```
AppMain/
 └── DI/
      └── AppDIContainer.swift
      ※ 依存関係の生成と注入を担当

UI層/
 └── [FeatureName]/
      ├── [FeatureName]View.swift
      └── [FeatureName]ViewModel.swift
      ※ SwiftUIの画面とロジックを管理

Domain層/
 ├── Model/
 │    ├── User.swift
 │    └── Article.swift
 │    ※ アプリ内部の純粋なデータ構造（Entity）
 │
 ├── Repository/
 │    ├── UserRepositoryProtocol.swift
 │    └── ArticleRepositoryProtocol.swift
 │    ※ Repositoryの抽象プロトコル
 │
 └── UseCase/
      ├── FetchUserUseCase.swift
      └── FetchArticlesUseCase.swift
      ※ ビジネスロジックを担当

Data層/
 ├── DTO/
 │    ├── UserDTO.swift
 │    └── ArticleDTO.swift
 │    ※ 外部データ(API, DB)を受け取る構造体
 │
 ├── DataSource/
 │    ├── APIDataSource.swift
 │    ├── UserDefaultsDataSource.swift
 │    └── DBDataSource.swift
 │    ※ 実際のデータ取得（API通信・ローカルアクセスなど）
 │
 ├── RepositoryImpl/
 │    ├── UserRepositoryImpl.swift
 │    └── ArticleRepositoryImpl.swift
 │    ※ RepositoryProtocolの実装
 │
 └── Mapper/
      ├── UserMapper.swift
      └── ArticleMapper.swift
      ※ DTO → Modelへの変換

Utility/
 ├── Logger.swift
 └── Extensions/
      └── Date+Format.swift
      ※ 共通処理・ログ・拡張メソッドなど

Resource/
 ├── Asset+Color.swift
 ├── Asset+Image.swift
 └── Localizable.strings
      ※ 画像、色、テキストなどのリソース管理
```

---

## 🧩 各層の責務概要

| 層 | 主な責務 | 例 |
|----|-----------|----|
| **UI層** | View（描画）とViewModel（状態管理） | SwiftUI View, ViewModel |
| **Domain層** | ビジネスロジックの中心。アプリのルール定義 | UseCase, RepositoryProtocol, Entity |
| **Data層** | データの取得・変換。外部ソースとの橋渡し | RepositoryImpl, DataSource, Mapper, DTO |
| **Utility層** | 共通的な小機能や拡張 | Logger, Extensions |
| **Resource層** | アセットやローカライズ文字列など | 画像・カラー管理 |

---

## ⚙️ 技術構成

| 項目 | 使用技術 |
|------|-----------|
| 言語 | Swift 5.10+ |
| UI | SwiftUI |
| 通信 | URLSession / （必要に応じてAlamofire） |
| DI | 独自DIコンテナ（AppDIContainer） |
| アーキテクチャ | Clean Architecture（軽量構成） |
| 対応OS | iOS 17.0+ |
| ビルドツール | Xcode 16+ |

---

## 💉 依存性注入の流れ

```
[View] → [ViewModel]
     ↳ FetchUseCase
          ↳ RepositoryProtocol
               ↳ RepositoryImpl
                    ↳ DataSource(API / Local)
```

すべての依存関係は `AppDIContainer` で生成・注入。  
各レイヤーはプロトコル経由で疎結合を維持しています。

---

## 🧠 Mapperの役割

- **目的**：DTO（外部データ）をModel（アプリ内部データ）へ変換する  
- **効果**：RepositoryImplをシンプル化・テスト容易化  
- **イメージ**：  
  「外のフォーマットをアプリ内の“扱いやすい箱”に入れ替える変換係」

### 例：

```swift
// DTO
struct UserDTO: Decodable {
    let id: Int
    let user_name: String
}

// Model
struct User: Identifiable {
    let id: Int
    let name: String
}

// Mapper
struct UserMapper {
    static func map(dto: UserDTO) -> User {
        User(id: dto.id, name: dto.user_name)
    }
}
```

---

## 🧩 DTOの役割

- APIやDBから取得した**外部データ構造**を定義するもの  
- Swiftの命名・型変換とは独立して管理  
- Mapperを通してDomain層の`Model`へ変換される  

---

## 🧩 AppDIContainerの役割

依存関係を一括で管理するクラス。  
テストやMock差し替えを容易にする目的で導入。

```swift
final class AppDIContainer {
    static let shared = AppDIContainer()
    private init() {}

    // MARK: - DataSource
    private let apiDataSource = APIDataSource()
    private let localDataSource = UserDefaultsDataSource()

    // MARK: - Repository
    private func makeUserRepository() -> UserRepositoryProtocol {
        UserRepositoryImpl(api: apiDataSource, local: localDataSource)
    }

    // MARK: - UseCase
    private func makeFetchUserUseCase() -> FetchUserUseCaseProtocol {
        FetchUserUseCase(repository: makeUserRepository())
    }

    // MARK: - ViewModel
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(fetchUserUseCase: makeFetchUserUseCase())
    }
}
```

---

## 🧩 今後の拡張アイデア

- ✅ **MockRepository**を追加して単体テスト実施  
- ✅ **Logger**で開発中のイベントを記録  
- ✅ **ErrorHandler**でエラーメッセージを統一管理  
- ✅ **CacheLayer（MemoryCache, DiskCache）** をDataSourceに追加  

---

## 🧭 まとめ

| ポイント | 内容 |
|-----------|------|
| **アーキテクチャ** | クリーンアーキテクチャ（軽量構成） |
| **Infra層** | 省略。Data層でデータ取得も担当 |
| **Mapper** | DTO → Model変換の翻訳者 |
| **DI** | AppDIContainerで統一管理 |
| **利点** | 責務分離・テスト容易性・スケールしやすさ |
| **対象規模** | 個人開発〜中規模プロジェクトに最適 |

---

## 💬 最後に一言

> この構成は「現実的なクリーンアーキテクチャ」です。  
> クラス数を最小限に保ちつつ、責務を整理して保守性を高めることを目的としています。  
> SwiftUIと相性が良く、将来的なInfra層分離やMockテストにも発展可能です。🚀
