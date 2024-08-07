//
//  MyReviewsView.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MyReviewsListView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ScrollView {
            ZSText("(reviewCount)개의 리뷰를 작성했어요", fontType: .heading1, color: Color.neutral900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10,leading: 22,bottom: 30,trailing: 22))
            
            ForEach(0..<5, id: \.self) { review in
                VStack(spacing: 0) {
                    ZSText("2024.06.28 작성", fontType: .body3, color: Color.neutral400)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 11)
                    
                    HStack {
                        Rectangle()
                            .fill(Color.neutral50)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        VStack(spacing: 0) {
                            ZSText("브랜드", fontType: .body3, color: Color.neutral500)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            
                            ZSText("상품명상품명상품명", fontType: .subtitle2, color: Color.neutral900)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                            HStack(spacing: 4) {
                                StarComponent(rating: 3, size: 16)
                                ZSText("3.7", fontType: .label1, color: Color.neutral700)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.vertical, -2)
                    }
                    .onTapGesture {
                        router.navigateTo(.myReivew)
                    }
                }
                .padding(.horizontal, 22)
                
                DivideRectangle(height: 1, color: Color.neutral50)
                    .padding(.vertical, 30)
                    .opacity(review == 4 ? 0 : 1)
            }
        }
        .ZSNavigationBackButtonTitle("내가 작성한 리뷰") {
            router.navigateBack()
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder func productInfo() -> some View {
        
    }
}

#Preview {
    MyReviewsListView()
}
