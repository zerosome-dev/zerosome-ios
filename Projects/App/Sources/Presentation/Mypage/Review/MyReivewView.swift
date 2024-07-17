//
//  MyReivewView.swift
//  App
//
//  Created by 박서연 on 2024/07/17.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MyReivewView: View {
    
    let data = SampleProduct.sampleProduct
    @State private var text: String = ""
    @State private var dynamicHeight: CGFloat = 100
    @State private var starCounting: Int = 0
    @State private var isPresented: Bool = false
    @State private var isAlert: Bool = false
    @EnvironmentObject var router: Router
    
    var body: some View {
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
                    ZSText("상품은 어떠셨나요?", fontType: .subtitle1)
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
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topTrailing) { popup() }
        .onTapGesture { isPresented = false }
        .ZSNavigationDoubleButton("내가 작성한 리뷰") {
            router.navigateBack()
        } rightAction: {
            isPresented.toggle()
        }
        .ZAlert(isShowing: $isAlert,
                type: .doubleButton(title: "리뷰를 삭제할까요?",
                                    LButton: "닫기",
                                    RButton: "삭제하기"),
                leftAction: {
            isAlert = false
        }, rightAction: {
            print("삭제완료")
            isAlert = false
        })
    }
    
    @ViewBuilder func popup() -> some View {
        MypagePopup()
            .tapRemove {
                print("리뷰 삭제")
                isPresented = false
                isAlert = true
            }
            .tapUpdate {
                print("리뷰 수정")
                isPresented = false
                router.navigateTo(.userReivewList)
            }
            .opacity(isPresented ? 1 : 0)
            .offset(x: -22)
    }
}

#Preview {
    MyReivewView()
}
