//
//  CarouselContetView.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct NewProductReleasedView: View {
    private let category = ["#생수/음료", "#탄산음료"]
    private let store = ["쿠팡", "이마트", "판매처"]
    
    var body: some View {
        VStack(spacing: 14) {
            Rectangle()
                .fill(Color.neutral200)
                .frame(height: 216)
                .frame(maxWidth: .infinity)
            
            VStack {
                CustomScrollView(data: category, type: .category)
                    .padding(.bottom, 6)
                
                Text("상품명상품명상품명")
                    .applyFont(font: .subtitle1)
                    .lineLimit(1)
                    .padding(.bottom, 15)
                
                CustomScrollView(data: store, type: .store)
                    .padding(.bottom, 16)
            }
            .frame(alignment: .center)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NewProductReleasedView()
}

enum ScrollData {
    case category
    case store
}

struct CustomScrollView: View {
    let data: [String]
    let type: ScrollData
    
    var body: some View {
        switch type {
        case .category:
            HStack(spacing: 8) {
                ForEach(data, id: \.self) { index in
                    Text(index)
                        .foregroundStyle(Color.neutral500)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        case .store:
            HStack(spacing: 6) {
                ForEach(data, id: \.self) { index in
                    Text(index)
                        .padding(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .applyFont(font: .label1)
                        .foregroundStyle(Color.neutral700)
                        
                }
            }
        }
        
    }
}
