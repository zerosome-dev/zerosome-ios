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
                VStack(spacing: 5) {
                    Image(systemName: item.image)
                        .frame(width: 24, height: 24)
                    Text(item.title)
                        .applyFont(font: .label1)
                        .foregroundStyle(Color.neutral400)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .contentShape(Rectangle())
                .padding(.bottom, 10)
                .onTapGesture {
                    viewModel.selected = item
                    print("item \(item)")
                }
            }
        }
        .padding(.top, 10)
        .background(.white)
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
