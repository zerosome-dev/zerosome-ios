//
//  TabbarView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct TabbarView: View {
    @ObservedObject var viewModel: TabbarViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tabbar.allCases, id: \.self) { item in
                    VStack(spacing: 3) {
                        (viewModel.selected == item ? item.image_fill : item.image_default)
                            .resizable()
                            .frame(width: 22, height: 22)
                        ZSText(item.title, fontType: .body4, color: viewModel.selected == item
                               ? Color.primaryFF6972 : Color.neutral400)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selected = item
                    }
                }
            }
        }
        .padding(.top, 5)
        .background(Color.white)
        .shadow(color: .black.opacity(0.03), radius: 1, y: -2.0)
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
