//
//  UpdateReviewView.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct SampleProduct {
    let name: String
    let brand: String
    let content: String
    
    static let sampleProduct = SampleProduct(name: "파워에이드", brand: "노브랜드", content: "상품입니다상품입니다상품입니다상품입니다")
}


struct UpdateReviewView: View {
    
    let data = SampleProduct.sampleProduct
    @EnvironmentObject var router: Router
    @State private var text: String = ""
    @State private var dynamicHeight: CGFloat = 100
    @State private var starCounting: Int = 0
    @State private var isAlert: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "수정 완료", font: .subtitle1)
                .enable(
                    !text.isEmpty
                )
                .tap {
                    isAlert = true
                }
                .padding(.horizontal, 22)
                .zIndex(1)
            
            ScrollView {
                VStack(spacing: 30) {
                    Rectangle()
                        .fill(Color.neutral100)
                        .frame(width: 240, height: 240)
                        .padding(.top, 10)
                    
                    VStack(spacing: 6) {
                        ZSText("[\(data.brand)]", fontType: .body2, color: Color.neutral500)
                        ZSText(data.name, fontType: .subtitle1, color: Color.neutral900)
                            .lineLimit(1)
                    } .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral100)
                    
                    VStack(spacing: 10) {
                        ZSText("상품은 만족스러웠나요?", fontType: .subtitle1)
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
                    
                    DynamicHeightTextEditor(
                        text: $text, dynamicHeight: $dynamicHeight,
                        initialHeight: 100, radius: 10,
                        font: .body2, backgroundColor: Color.white,
                        fontColor: Color.neutral700,
                        placeholder: "리뷰를 남겨주세요",
                        placeholderColor: Color.neutral300
                    )
                    .padding(.horizontal, 22)
                }
            }
            .scrollIndicators(.hidden)
            .ZSNavigationBackButtonTitle("리뷰 수정") {
                router.navigateBack()
            }
            .padding(.bottom, 52)
        }
        // aler 수정 필요
//        .ZAlert(isShowing: $isAlert,
//                type: .singleButton(title: "수정이 완료되었어요!", button: "확인"),
//                rightAction:  {
//            isAlert = false
//            router.navigateTo(.reviewList)
//        })
    }
}
#Preview {
    UpdateReviewView()
}
