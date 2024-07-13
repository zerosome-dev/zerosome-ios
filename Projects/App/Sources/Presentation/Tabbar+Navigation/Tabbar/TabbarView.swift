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
        HStack {
            HStack {
                ForEach(Tabbar.allCases, id: \.self) { item in
                    VStack(spacing: 5) {
                        (viewModel.selected == item ? item.image_fill : item.image_default)
                            .frame(width: 24, height: 24)
                        Text(item.title)
                            .applyFont(font: .label1)
                            .foregroundStyle(viewModel.selected == item ? Color.primaryFF6972 : Color.neutral400)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .padding(.bottom, 10)
                    .onTapGesture {
                        viewModel.selected = item
                    }
                }
            }
        }
        .frame(height: 66)
        .background(Color.white)
        .shadow(color: .black.opacity(0.03), radius: 1, y: -2.0)
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
