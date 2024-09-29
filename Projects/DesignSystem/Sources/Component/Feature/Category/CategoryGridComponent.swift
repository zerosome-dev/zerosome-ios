//
//  CategoryGridView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CategoryGridView: View {
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    private let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
    public let data: [String]
    
    public init(data: [String]) {
        self.data = data
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(data, id: \.self) { type in
                VStack(spacing: 6) {
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(width: size, height: size)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text(type)
                        .foregroundStyle(Color.neutral900)
                        .applyFont(font: .body2)
                }
            }
        }
    }
}

public struct CategoryGridComponent: View {
    
    public let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    public let data: [String]
    public let title: String
    public let last: Bool
    public let after: Bool
    public var action: (() -> Void)?
    public var pageAction: (() -> Void)?
    @Binding public var tapData: String
    
    public init(data: [String],
                title: String,
                last: Bool,
                after: Bool,
                action: (() -> Void)? = nil,
                pageAction: (() -> Void)? = nil,
                tapData: Binding<String>
    ) {
        self.data = data
        self.title = title
        self.last = last
        self.after = after
        self.action = action
        self.pageAction = pageAction
        self._tapData = tapData
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
 
            if after {
                HStack {
                    Text(title)
                        .foregroundStyle(Color.neutral900)
                        .applyFont(font: .heading2)
                    Spacer()
                    ZerosomeAsset.ic_arrow_after
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .onTapGesture {
                    pageAction?()
                }
            } else {
                Text(title)
                    .applyFont(font: .heading2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { type in
                    VStack(spacing: 6) {
                        Rectangle()
                            .fill(Color.neutral50)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text(type)
                            .foregroundStyle(Color.neutral900)
                            .applyFont(font: .body2)
                            
                    }
                    .onTapGesture {
                        tapData = type
                        pageAction?()
                    }
                }
            }
            
            if data.count > 8 { // 8개 이상일 때만 전체 보기 
                Text("전체 보기")
                    .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding(.top, 18)
            } else {
                EmptyView()
            }
        }
        .padding(.horizontal, 22)
        
        if last {
            EmptyView()
        } else {
            DivideRectangle(height: 12, color: Color.neutral50)
                .padding(.vertical, 30)
        }
    }
}

public extension CategoryGridComponent {
    func tapPageAction(_ pageAction: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.pageAction = pageAction
        return copy
    }
    
    func tapAction(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

#Preview {
    CategoryGridComponent(data: ["11", "22"],
                          title: "카페",
                          last: false,
                          after: true,
                          tapData: .constant("data"))
}
