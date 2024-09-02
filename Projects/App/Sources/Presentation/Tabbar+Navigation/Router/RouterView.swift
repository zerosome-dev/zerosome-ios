//
//  RouterView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @EnvironmentObject var toast: ToastAction
    @EnvironmentObject var popup: PopupAction
    private let content: Content
    let apiService: ApiService
    
    init(
        apiService: ApiService,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.apiService = apiService
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                content
                    .environmentObject(toast)
                    .environmentObject(popup)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route, with: apiService, toast: toast)
            }
        }
        .environmentObject(router)
        .ZToast(toast.binding(for: toast.toastToggle),
                toast.toastToggle.type,
                toast.toastToggle.desc)
        .ZAlert(
            isShowing: popup.binding(for: popup.singleToggle),
            type: .singleButton(
                title: popup.singleToggle.title,
                button: popup.singleToggle.button
            ),
            leftAction: { popup.setToggle(for: popup.singleToggle, false) }
        )
        .ZAlert(
            isShowing: popup.binding(for: popup.doubleToggle),
            type: .doubleButton(
                title: popup.doubleToggle.title,
                LButton: popup.doubleToggle.left,
                RButton: popup.doubleToggle.right
            ),
            leftAction: { popup.setToggle(for: popup.singleToggle, false) },
            rightAction: { popup.rightButtonTapped = true }
            // rightButtonTapped를 통해서 environment로 뿌려진 팝업 상태 알고 rightAction 정의하기....
        )
    }
}
