//
//  CreateReviewView.swift
//  App
//
//  Created by 박서연 on 2024/06/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct SampleProduct {
    let name: String
    let brand: String
    let content: String
    
    static let sampleProduct = SampleProduct(name: "파워에이드", brand: "노브랜드", content: "상품입니다상품입니다상품입니다상품입니다")
}

struct CreateReviewView: View {

    let data: ReviewEntity
    @State private var text: String = ""
    @State var starCounting: Int = 0
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "작성 완료", font: .subtitle1)
                .enable(
                    // TODO: -  Button 조건 수정
                    !text.isEmpty
                )
                .tap {
                    router.navigateBack()
                    // TODO: - 서버로 리뷰 전송
                }
                .padding(.horizontal, 22)
                .padding(.top, -2)
                .zIndex(1)
            
            ScrollView {
                VStack(spacing: 30) {
                    KFImage(URL(string: data.image))
                        .placeholder {
                            ProgressView()
                                .tint(Color.primaryFF6972)
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
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
                    
                    ZSTextEditor(
                        content: $text,
                        placeholder: "제품에 대한 의견을 자유롭게 남겨주세요",
                        maxCount: 1000
                    )
                    .padding(22)
                }
            }
            .scrollIndicators(.hidden)
        }
        .ZSnavigationBackButton {
            router.navigateBack()
        }
    }
}

#Preview {
    CreateReviewView(data: ReviewEntity(name: "name", brand: "brand", productId: 12, image: ""))
}
