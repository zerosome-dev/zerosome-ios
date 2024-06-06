//
//  CategoryGridView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/07.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct CategoryGridView: View {
    
    public let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    public let data: [String]
    public let type: String
    public let last: Bool
    public let pageSpacing: CGFloat
    public let gridSpacing: CGFloat
    
    public init(data: [String],
         type: String,
         last: Bool,
         pageSpacing: CGFloat,
         gridSpacing: CGFloat
    ) {
        self.data = data
        self.type = type
        self.last = last
        self.pageSpacing = pageSpacing
        self.gridSpacing = gridSpacing
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            let size = (UIScreen.main.bounds.width - (pageSpacing * 2) - (gridSpacing * 3)) / 4
            
            Text(type)
                .applyFont(font: .heading2)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { type in
                    VStack(spacing: 6) {
                        Rectangle()
                            .fill(Color.neutral50)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text(type)
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral900)
                    }
                }
            }
        }
        .padding(.horizontal, 22)
        
        if last {
            EmptyView()
        } else {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 12)
                .foregroundStyle(Color.neutral50)
                .padding(.vertical, 30)
        }
    }
}

#Preview {
    CategoryGridView(data: ["11", "22"], type: "카페", last: false, pageSpacing: 22, gridSpacing: 17)
}
