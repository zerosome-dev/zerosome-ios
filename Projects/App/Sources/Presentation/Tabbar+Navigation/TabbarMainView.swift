//
//  TabbarMainView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct TabbarMainView: View {
    @StateObject public var viewModel = TabbarViewModel()
    
    var body: some View {
//        ZStack(alignment: .bottom) {
//            TabView(selection: $viewModel.selected) {
//                ForEach(Tabbar.allCases, id: \.self) { tab in
//                    tab.view
//                }
//                .toolbarBackground(.hidden, for: .tabBar)
//            }
//            
//            TabbarView(viewModel: viewModel)
//                .edgesIgnoringSafeArea(.bottom)
//        }
        VStack(spacing: 0) {
            TabView(selection: $viewModel.selected) {
                ForEach(Tabbar.allCases, id: \.self) { tab in
                    tab.view
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
            TabbarView(viewModel: viewModel)
//                .edgesIgnoringSafeArea(.bottom)
        }
//        .overlay {
//            VStack {
//                Spacer()
//                TabbarView(viewModel: viewModel)
//                    .edgesIgnoringSafeArea(.bottom)
//            }
//        }
    }
}

#Preview {
    TabbarMainView()
}
