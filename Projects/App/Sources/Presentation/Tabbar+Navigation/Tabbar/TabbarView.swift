//
//  TabbarView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
    @ObservedObject var viewModel: TabbarViewModel
    
    var body: some View {
        HStack {
            ForEach(Tabbar.allCases, id: \.self) { item in
                Button {
                    viewModel.selected = item
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "house")
                            .frame(width: 39, height: 39)
                        Text(item.title)
                            .applyFont(font: .label1)
                            .foregroundStyle(Color.neutral400)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
                .onTapGesture {
                    viewModel.selected = item
                }
            }
        }
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
