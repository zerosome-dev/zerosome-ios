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
    @EnvironmentObject var popup: PopupAction
    @EnvironmentObject var toast: ToastAction
    let apiService: ApiService
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view(with: apiService)
                        .environmentObject(popup)
                        .environmentObject(toast)
                }
            }
            TabbarView(viewModel: viewModel)
                .background(ignoresSafeAreaEdges: .bottom)
        }
    }
}

#Preview {
    TabbarMainView(apiService: ApiService())
        .environmentObject(ToastAction())
        .environmentObject(PopupAction())
}


