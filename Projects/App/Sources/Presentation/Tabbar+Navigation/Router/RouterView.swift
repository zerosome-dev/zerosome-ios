//
//  RouterView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                content
            }
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .environmentObject(router)
    }
}
