//
//  ProductDetailView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    private let storeSample = ["네이버 쇼핑", "쿠팡", "판매처명"]
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.neutral500)
                .scaledToFit()
                
            Text("브랜드명브랜드명브랜드명")
            Text("[상품명상품명상품명상품명상품명]")
            
            ForEach(0..<5) { index in
                HStack{
                    Text("영양성분명1")
                    Spacer()
                    Text("영양성분")
                }
                .padding(.vertical, 14)
                
                Rectangle()
                    .fill(Color.neutral100)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .opacity(index == 4 ? 0 : 1)
            }
            
            Text("영양 성분 모두 보기")
                .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral400)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.neutral400, lineWidth: 1)
                }
            
            Text("오프라인 판매처")
            
            Text("온라인 판매처")
            LazyVStack(spacing: 10) {
                ForEach(storeSample, id: \.self){ store in
                    Text(store)
                        .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            Spacer().frame(height: 30)
            
            
        }
    }
}

#Preview {
    ProductDetailView()
}
