//
//  CreateReviewView.swift
//  App
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import AutoHeightEditor

struct SampleProduct {
    let name: String
    let brand: String
    let content: String
    
    static let sampleProduct = SampleProduct(name: "파워에이드", brand: "노브랜드", content: "상품입니다상품입니다상품입니다상품입니다")
}

struct CreateReviewView: View {
    let data = SampleProduct.sampleProduct
    @State private var text: String = ""
    @State var dynamicHeight: CGFloat = 100
    @State var starCounting: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "작성 완료", font: .subtitle1)
                .enable(
                    // TODO: -  Button 조건 수정
                    !text.isEmpty
                )
                .padding(.horizontal, 22)
                .padding(.top, -2)
            
            ScrollView {
                VStack(spacing: 30) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                    
                    VStack(spacing: 6) {
                        ZSText("[\(data.brand)]", fontType: .body2, color: Color.neutral500)
                        ZSText(data.name, fontType: .subtitle1, color: Color.neutral900)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral100)
                    
                    VStack(spacing: 10){
                        ZSText("상품은 만족스러웠나요?", fontType: .subtitle1, color: .black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { index in
                                (index <= starCounting ? ZerosomeAsset.ic_star_fill : ZerosomeAsset.ic_star_empty)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .onTapGesture {
                                        starCounting = index
                                    }
                            }
                        }
                    }
                    
                    DynamicHeightTextEditor(text: $text, dynamicHeight: $dynamicHeight,
                                            initialHeight: 100, radius: 10,
                                            font: .body2, backgroundColor: Color.white,
                                            fontColor: Color.neutral700,
                                            placeholder: "리뷰를 남겨주세요",
                                            placeholderColor: Color.neutral300).padding(.horizontal, 22)
                    
                            
                   
                }
            }.scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CreateReviewView()
}
