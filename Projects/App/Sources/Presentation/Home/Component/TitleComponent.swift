//
//  TitleComponent.swift
//  App
//
//  Created by 박서연 on 2024/09/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct TitleComponent: View {
    let title: String
    let subTitle: String
    var action: (() -> ())?
    
    init(
        title: String,
        subTitle: String,
        action: (() -> Void)? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                ZSText(title, fontType: .heading1)
                Spacer()
                HStack(spacing: 0) {
                    ZSText("더보기", fontType: .caption, color: Color.neutral700)
                    ZerosomeAsset.ic_arrow_after
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
            
            ZSText(subTitle, fontType: .body2, color: Color.neutral500)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

extension TitleComponent {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
struct HomeCategoryComponent: View {
    @ObservedObject var viewModel: HomeMainViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.cafeCategoryList, id: \.id) { category in
                    ZSText(category.d2CategoryName, fontType: .label1, color:
                            viewModel.tappedCafeCategory == category.d2CategoryName
                           ? Color.white
                           : Color.neutral400
                    )
                    .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
                    .background(
                        viewModel.tappedCafeCategory == category.d2CategoryName
                        ? Color.primaryFF6972
                        : Color.neutral50
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        viewModel.tappedCafeCategory = category.d2CategoryName
                        viewModel.filteredCafe = viewModel.homeCafe.filter({ $0.brand == viewModel.tappedCafeCategory })
                        
                    }
                }
            }
        }
    }
}
