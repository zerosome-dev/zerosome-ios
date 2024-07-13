//
//  HomeSubTitleView.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct HomeCategoryTitleView: View {
    enum TitleType {
        case none
        case moreButton
    }
    
    let title: String
    let subTitle: String
    let type: TitleType
    let paddingType: Bool
    let data: [String]?
    let action: (() -> Void)?
    let columns: [GridItem] = [.init(.flexible(), spacing: 10, alignment: .center)]
    @State private var categoryList: [String] = [] // 유저가 선택하는 카테고리
    
    init(title: String,
         subTitle: String,
         type: TitleType,
         paddingType: Bool,
         data: [String]? = nil,
         action: (() -> Void)? = nil)
    {
        self.title = title
        self.subTitle = subTitle
        self.type = type
        self.paddingType = paddingType
        self.data = data
        self.action = action
    }

    var body: some View {
        VStack(spacing: 12) {
            titleView
            
            if type == .moreButton {
                categoryView
                    .padding(.bottom, 8)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { i in
                            ProductPreviewComponent()
                                .frame(maxWidth: 150)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
        }
        .padding(.horizontal, paddingType ? 22 : 0)
    }

    @ViewBuilder
    private var titleView: some View {
        VStack(spacing: 2) {
            HStack {
                Text(title)
                    .applyFont(font: .heading1)
                Spacer()
                if type == .moreButton {
                    moreButton
                }
            }
            
            Text(subTitle)
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var moreButton: some View {
        HStack(spacing: 0) {
            Text("더보기")
            ZerosomeAsset.ic_arrow_after
                .resizable()
                .frame(width: 16, height: 16)
        }
        .applyFont(font: .caption)
        .foregroundStyle(Color.neutral700)
        .onTapGesture {
            action?()
        }
    }
    
    @ViewBuilder
    private var categoryView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(data ?? [], id: \.self) { index in
                    Text(index)
                        .padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .applyFont(font: .label1)
                        .foregroundStyle(categoryList.contains(index) ? Color.white :  Color.neutral400)
                        .background(categoryList.contains(index) ? Color.primaryFF6972 : Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .onTapGesture {
                            toggleSelection(of: index)
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .animation(.easeOut, value: categoryList)
        .frame(height: 30)
    }
    
    private func toggleSelection(of index: String) {
        if let existingIndex = categoryList.firstIndex(of: index) {
            categoryList.remove(at: existingIndex)
        } else {
            categoryList.append(index)
        }
    }
}



#Preview {
    HomeCategoryTitleView(title: "제목입니다.",
                          subTitle: "서브타이틀입니다.",
                          type: .moreButton,
                          paddingType: true,
                          data: ZeroDrinkSampleData.drinkType)
}
    