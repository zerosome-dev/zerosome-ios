//
//  TabbarMainView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct TabbarMainView: View {
    @StateObject var viewModel = TabbarViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view
                        .padding(.bottom, 35)
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
            .overlay(alignment: .bottom) {
                TabbarView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    TabbarMainView()
}
