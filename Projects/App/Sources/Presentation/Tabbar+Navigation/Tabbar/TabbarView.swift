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
    @EnvironmentObject var router: Router
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .shadow(color: .black.opacity(0.01), radius: 1, y: -2.0)
            .blur(radius: 8)
            .shadow(radius: 10)
            .frame(height: 66)
            .overlay {
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
                        }
//                        .simultaneousGesture(TapGesture(count: 2).onEnded {
//                            router.popToRoot()
//                        })
                    }
                }
                .padding(.top, 10)
                .background(.white)
            }
        
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
