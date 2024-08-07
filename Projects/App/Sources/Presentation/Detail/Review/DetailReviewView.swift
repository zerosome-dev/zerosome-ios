//
//  DetailReviewView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct DetailReviewView: View {
    
    let data = [2 : ["content1", "content2", "content3"]]
    let reviewCounting: Int?
    var action: (() -> Void)?
    
    init(
        reviewCounting: Int?,
        action: (() -> Void)? = nil
    
    ) {
        self.reviewCounting = reviewCounting
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if reviewCounting == 0 {
                CommonTitle(title: "아직 리뷰가 없어요", type: .solo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 62)
                NoneReviewView(action: action)
                    .padding(.bottom, 83)
            } else {
                HStack {
                    ZSText("리뷰 (reviewCounting)", fontType: .heading2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        ZSText("더보기", fontType: .caption, color: Color.neutral700)
                        ZerosomeAsset.ic_arrow_after
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
                .padding(.bottom, 12)
                .onTapGesture {
                    action?()
                }
                
                ReviewScoreComponent(
                    background: Color.neutral50,
                    heightPadding: 18,
                    radius: 8,
                    review: "4.3",
                    font: .heading2
                )

                    .padding(.bottom, 20)
                
                // TODO: - Carousel, component수정
                VStack(spacing: 16) {
                    HStack{
                        StarComponent(rating: 4, size: 16)
                        ZSText("4.7", fontType: .subtitle2, color: Color.neutral700)
                        Spacer()
                        ZSText("2024.06.05", fontType: .body4, color: Color.neutral400)
                    }
                    
                    ZSText("리뷰입니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰...", fontType: .body2, color: Color.neutral700)
                        .lineLimit(2)
                }
                .padding(14)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.neutral100, lineWidth: 1)
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

struct ReviewScoreComponent: View {
    let background: Color
    let heightPadding: CGFloat
    let radius: CGFloat
    let review: String
    let font: ZSFont
    
    var body: some View {
        VStack(spacing:2) {
            Text(review)
                .applyFont(font: font)

            StarComponent(rating: 4, size: 16)
        }
        .padding(.vertical, heightPadding)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DetailReviewView(reviewCounting: 1)
}

extension DetailReviewView {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
