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
            Text("리뷰 2")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            
            ReviewScoreComponent(background: Color.neutral50,
                                 heightPadding: 18, radius: 0)
                .padding(.bottom, 20)
            
            // TODO: - Carousel, component수정
            VStack(spacing: 16) {
                HStack{
                    Image(systemName: "star")
                        .padding(.trailing, 4)
                    Text("4.7")
                        .foregroundStyle(Color.neutral700)
                    Spacer()
                    Text("2024.06.05")
                        .foregroundStyle(Color.neutral400)
                }
                
                Text("리뷰입니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰는두줄까지노출합니다리뷰...")
                    .lineLimit(2)
                    .foregroundStyle(Color.neutral700)
                    .applyFont(font: .body2)
            }
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.neutral100, lineWidth: 1)
            }
            
            CommonButton(title: "리뷰 작성", font: .subtitle1)
        }
    }
}

struct ReviewScoreComponent: View {
    let background: Color
    let heightPadding: CGFloat
    let radius: CGFloat
    
    var body: some View {
        VStack(spacing:2) {
            Text("4.3")
                .applyFont(font: .heading2)
            Image(systemName: "star")
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
