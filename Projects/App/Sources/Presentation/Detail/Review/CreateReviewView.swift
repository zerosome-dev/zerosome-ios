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
    @State var finish = false
    @State var test = false
    @State var text: String = ""
    @State var dynamicHeight: CGFloat = 100
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 6) {
                    Text("[\(data.brand)]")
                        .applyFont(font: .body2)
                        .foregroundStyle(Color.neutral700)
                    Text(data.name)
                        .applyFont(font: .subtitle2)
                        .foregroundStyle(Color.neutral900)
                        .lineLimit(1)
                }
                .padding(.horizontal, 22)
                
                DivideRectangle(height: 1, color: Color.neutral100)
                
                VStack(spacing: 10){
                    Text("상품은 어떠셨나요?")
                        .applyFont(font: .subtitle1)
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack(spacing: 2){
                        ForEach(0..<5) { _ in
                            Image(systemName: "star")
                                .font(.system(size: 36))
                                .foregroundStyle(Color.neutral200)
                        }
                    }
                }
                
                DynamicHeightTextEditor(text: $text, dynamicHeight: $dynamicHeight,
                                        initialHeight: 100, radius: 10,
                                        font: .body2, backgroundColor: Color.neutral50,
                                        fontColor: Color.neutral700,
                                        placeholder: "리뷰를 남겨주세요",
                                        placeholderColor: Color.neutral500)   .padding(.horizontal, 22)
                
                        
                CommonButton(title: "작성 완료", font: .subtitle1)
                    .enable(
                        // TODO: -  Button 조건 수정
                        !text.isEmpty
                    )
                    .padding(.horizontal, 22)
                    .padding(.top, -2)
            }
        }
    }
}

#Preview {
    CreateReviewView()
}
