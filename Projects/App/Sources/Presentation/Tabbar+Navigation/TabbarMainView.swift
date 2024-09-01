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
    let apiService: ApiService
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view(with: apiService)
                }
            }
            TabbarView(viewModel: viewModel)
                .background(ignoresSafeAreaEdges: .bottom)
        }
    }
}

#Preview {
    TabbarMainView(apiService: ApiService())
}
