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
    
    var body: some View {
        VStack {
            HStack {
                Text("리뷰 (reviewCounting)")
                    .applyFont(font: .heading2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    Text("더보기")
                        .applyFont(font: .caption)
                        .foregroundStyle(Color.neutral700)
                    ZerosomeAsset.ic_arrow_after
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .onTapGesture {
                    print("리뷰 더보기 tapped")
                }
            }
            .padding(.bottom, 12)
            
            ReviewScoreComponent(background: Color.neutral50,
                                 heightPadding: 18, radius: 8, review: "4.3")
                .padding(.bottom, 20)
            
            // TODO: - Carousel, component수정
            VStack(spacing: 16) {
                HStack{
                    StarComponent(rating: 4)
                    Text("4.7")
                        .applyFont(font: .subtitle2)
                        .foregroundStyle(Color.neutral700)
                    Spacer()
                    Text("2024.06.05")
                        .foregroundStyle(Color.neutral400)
                        .applyFont(font: .body4)
                }
                
                Text("리뷰입니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰...")
                    .foregroundStyle(Color.neutral700)
                    .applyFont(font: .body2)
                    .lineLimit(2)
            }
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.neutral100, lineWidth: 1)
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
    
    var body: some View {
        VStack(spacing:2) {
            Text(review)
                .applyFont(font: .heading2)
            StarComponent(rating: 4)
        }
        .padding(.vertical, heightPadding)
        .frame(maxWidth: .infinity)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DetailReviewView()
}
