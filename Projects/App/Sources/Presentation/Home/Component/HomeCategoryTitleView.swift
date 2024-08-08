//
//  HomeSubTitleView.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum HScrollProductType {
    case tobeReleased([HomeRolloutResponseDTO])
    case homeCafe([HomeCafeResponseDTO])
    
    func getItems<T: Decodable>() -> [T] {
        switch self {
        case .tobeReleased(let items):
            return items as? [T] ?? []
        case .homeCafe(let items):
            return items as? [T] ?? []
        }
    }
}

struct HomeCategoryTitleView: View {
    @State private var categoryList: [String] = [] // 유저가 선택하는 카테고리
    @Binding var tapData: Int
    
    let columns: [GridItem] = [.init(.flexible(), spacing: 10, alignment: .center)]
    
    enum TitleType {
        case none
        case noneData
        case moreButton
    }
    
    let title: String
    let subTitle: String
    let productType: HScrollProductType?
    let type: TitleType
    let paddingType: Bool?
    let d2Category: [String]?
    var action: (() -> Void)?
    var subAction: (() -> Void)?

    init (
        tapData: Binding<Int>,
        productType: HScrollProductType? = nil,
        title: String,
        subTitle: String,
        type: TitleType,
        paddingType: Bool? = true,
        d2Category: [String]? = nil,
        action: (() -> Void)? = nil,
        subAction: (() -> Void)? = nil
    ) {
        self._tapData = tapData
        self.productType = productType
        self.title = title
        self.subTitle = subTitle
        self.type = type
        self.paddingType = paddingType
        self.d2Category = d2Category
        self.action = action
        self.subAction = subAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            
            titleView
            
            if type == .moreButton {
                categoryView
                    .padding(.bottom, 8)
                ScrollView(.horizontal) {
                    HStack {
                        switch productType {
                        case .tobeReleased(let data):
                            if let type = productType {
                                let _: [HomeRolloutResponseDTO] = type.getItems()
                            }
                            
                        case .homeCafe(let data):
                            if let type = productType {
                                let _: [HomeCafeResponseDTO] = type.getItems()

                                ForEach(data.prefix(10), id: \.id) { data in
                                    ProductPreviewComponent(data: data)
                                        .tap {
                                            tapData = data.id ?? 0
                                            subAction?()
                                        }
                                }
                            }
                        case .none:
                            EmptyView()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.horizontal, (paddingType ?? true) ? 22 : 0)
    }
    
    @ViewBuilder
    private var titleView: some View {
        VStack(spacing: 2) {
            HStack {
                Text(title)
                    .applyFont(font: .heading1)
                Spacer()
                if type == .moreButton || type == .noneData {
                    moreButton
                }
            }
            
            Text(subTitle)
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
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
    }
    
    @ViewBuilder
    private var categoryView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(d2Category ?? [], id: \.self) { index in
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

extension HomeCategoryTitleView {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
    
    func tapSub(_ subAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.subAction = subAction
        return copy
    }
}

#Preview {
    HomeCategoryTitleView(tapData: .constant(1),
                          productType: .homeCafe([]),
                          title: "제목입니다.",
                          subTitle: "서브타이틀입니다.",
                          type: .noneData,
                          paddingType: true
    )
}

