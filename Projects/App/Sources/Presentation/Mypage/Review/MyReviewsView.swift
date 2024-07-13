//
//  MyReviewsView.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct MyReviewsView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("(reviewCount)개의 리뷰를 작성했어요")
                    .foregroundStyle(Color.neutral900)
                    .applyFont(font: .heading1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 30)
                
                ForEach(0..<5, id: \.self) { review in
                    VStack {
                        Text("2024.06.28 작성")
                            .applyFont(font: .body3)
                            .foregroundStyle(Color.neutral400)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Rectangle()
                                .fill(Color.neutral50)
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("[브랜드브랜드브랜드브랜드브랜드브랜드브랜드]")
                                    .applyFont(font: .body3)
                                    .foregroundStyle(Color.neutral500)
                                    .padding(.bottom, 2)
                                
                                Text("상품평상품평상품평상품평상품평상품평상품평상품평상품평상품평상품평").lineLimit(1)
                                    .applyFont(font: .subtitle2)
                                    .foregroundStyle(Color.neutral900)
                                    .padding(.bottom, 18)
                                
                                HStack(spacing: 4) {
                                    StarComponent(rating: 3)
                                    Text("4.7")
                                        .foregroundStyle(Color.neutral700)
                                        .applyFont(font: .label1)
                                }
                            }
                            .padding(.vertical, 2)
                        }
                        
                        
                        DivideRectangle(height: 1, color: Color.neutral50)
                            .padding(.vertical, 30)
                            .opacity(review == 4 ? 0 : 1)
                    }
                }
            } .padding(.horizontal, 22)
        }
        .ZSNavigationBackButtonTitle("내가 작성한 리뷰") {
            print("리뷰 창 나가기")
        }
    }
}

#Preview {
    NavigationStack {
        MyReviewsView()
    }
}
