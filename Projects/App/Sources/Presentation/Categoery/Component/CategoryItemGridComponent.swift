//
//  CategoryItemGridComponent.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct CategoryItemGridComponent: View {
    
    @State private var showAllItems: Bool = false
    @Binding public var tapData: Int?
    @Binding public var tapD2Category: D2CategoryResult?
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    var tapTitle: (() -> Void)?
    var tapItem: (() -> Void)?
    var data: D1CategoryResult
    
    var displayedData: [D2CategoryResult] {
        if showAllItems || data.d2Category.count <= 9 {
            return data.d2Category
        } else {
            return Array(data.d2Category.prefix(8))
        }
    }
    
    init(tapData: Binding<Int?>,
         tapD2Category: Binding<D2CategoryResult?>,
         data: D1CategoryResult,
         tapTitle: (() -> Void)? = nil,
         tapItem: (() -> Void)? = nil
    ) {
        self._tapData = tapData
        self._tapD2Category = tapD2Category
        self.data = data
        self.tapTitle = tapTitle
        self.tapItem = tapItem
    }
    
    var body: some View {
        VStack(spacing: 12 ){
            let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
            
            HStack {
                ZSText(data.d1CategoryName, fontType: .heading2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZerosomeAsset.ic_arrow_after
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .onTapGesture {
                print("tap title 범위 체킹!")
                tapTitle?()
            }
            
            VStack(spacing: 30) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(displayedData) { data in
                        if data.d2CategoryName == "전체" {
                            EmptyView()
                        } else {
                            SqureCompoment(
                                image: data.d2CategoryImage,
                                category: data.d2CategoryName,
                                size: size
                            )
                            .onTapGesture {
                                tapD2Category = data
                                tapItem?()
                            }
                        }
                    }
                }
                
                if data.d2Category.count > 8 && !showAllItems {
                    Text("전체 보기")
                        .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.top, 18)
                        .onTapGesture {
                            showAllItems = true
                        }
                }
            }
        }
    }
}

extension CategoryItemGridComponent {
    func tapTitle(_ titleAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.tapTitle = titleAction
        return copy
    }
    
    func tapItem(_ itemAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.tapItem = itemAction
        return copy
    }
}

struct SqureCompoment: View {
    let image: String
    let category: String
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 6) {
            KFImage(URL(string: image))
                .placeholder { progress in
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(width: size, height: size)
                        .overlay {
                            ProgressView().tint(Color.primaryFF6972)
                        }
                }
                .resizable()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            ZSText(category, fontType: .body3)
        }
    }
}
