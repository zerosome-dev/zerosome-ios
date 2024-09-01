//
//  TabbarMainView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct TabbarMainView: View {
    @StateObject var viewModel = TabbarViewModel()
    @StateObject var popup = PopupAction()
    let apiService: ApiService
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view(with: apiService)
                        .environmentObject(popup)
                }
            }
            TabbarView(viewModel: viewModel)
                .background(ignoresSafeAreaEdges: .bottom)
        }
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
                RButton: popup.doubleToggle.right),
            leftAction: { popup.setToggle(for: popup.singleToggle, false) },
            rightAction: { popup.rightButtonTapped = true } 
            // rightButtonTapped를 통해서 environment로 뿌려진 팝업 상태 알고 rightAction 정의하기....
        )
    }
}

#Preview {
    TabbarMainView(apiService: ApiService())
}


