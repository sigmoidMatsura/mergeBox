//
//  AuthRouter.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/11/12.
//

import SwiftUI
import Observation

enum AuthRoute: Hashable {
    case login
}

@Observable
final class AppRouter {
    var path = NavigationPath()
    
    func navigate(to route: AuthRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
