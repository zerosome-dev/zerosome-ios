//
//  CarouselContetView.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct CarouselContetView: View {
    private let category = ["#생수/음료", "#탄산음료"]
    private let store = ["쿠팡", "이마트", "판매처"]
    
    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                Color.gray.opacity(0.3)
                AsyncImage(url: URL(string: ZeroDrinkSampleData.url1)) { image in
                    image
                        .resizable()
                        .frame(width: 216, height: 216)
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(height: 216)
            
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
        .overlay {
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CarouselContetView()
}

enum ScrollData {
    case category
    case store
}

struct CustomScrollView: View {
    let data: [String]
    let type: ScrollData
    
    var body: some View {
        ScrollView(.horizontal) {
            switch type {
            case .category:
                HStack(spacing: 8) {
                    ForEach(data, id: \.self) { index in
                        Text(index)
                            .foregroundStyle(Color.gray.opacity(0.8))
                    }
                }
            case .store:
                HStack(spacing: 6) {
                    ForEach(data, id: \.self) { index in
                        Text(index)
                            .padding(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .applyFont(font: .label)
                            
                    }
                }
            }
        }
    }
}
