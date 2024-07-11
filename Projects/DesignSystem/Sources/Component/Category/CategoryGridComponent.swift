//
//  CategoryGridView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CategoryGridComponent: View {
    
    public let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    public let data: [String]
    public let title: String
    public let last: Bool
    public let duplicated: Bool
    public let total: Bool?
    
    public init(data: [String],
         title: String,
         last: Bool,
         duplicated: Bool,
         total: Bool? = true
    ) {
        self.data = data
        self.title = title
        self.last = last
        self.duplicated = duplicated
        self.total = total
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
 
            if duplicated {
                HStack {
                    Text(title)
                        .foregroundStyle(Color.neutral900)
                        .applyFont(font: .heading2)
                    Spacer()
                    Text("중복 선택 불가")
                        .foregroundStyle(Color.neutral500)
                        .applyFont(font: .body3)
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
                }
            }
            
            if total ?? true {
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
            Rectangle()
                .foregroundStyle(Color.neutral50)
                .frame(maxWidth: .infinity)
                .frame(height: 12) 
                .padding(.vertical, 30)
        }
    }
}

#Preview {
    CategoryGridComponent(data: ["11", "22"],
                          title: "카페",
                          last: false,
                          duplicated: true,
                          total: true)
}
