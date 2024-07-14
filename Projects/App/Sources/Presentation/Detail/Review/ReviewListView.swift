//
//  ReviewListView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ReviewListView: View {
    @State var plus: Bool = false
    @State var data = ReviewSampleData.reivewSample
    
    var body: some View {
        ScrollView {
            ReviewScoreComponent(background: Color.neutral50,
                                 heightPadding: 38, radius: 8, review: "4.3", font: .review)
            .padding(.init(top: 10, leading: 22, bottom: 30, trailing: 22))
            
            LazyVStack(spacing: 0) {
                ForEach($data, id: \.id) { $index in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(index.user)
                                .applyFont(font: .subtitle2)
                                .foregroundStyle(Color.neutral700)
                            Spacer()
                            Text(index.date)
                                .foregroundStyle(Color.neutral400)
                                .applyFont(font: .body4)
                        }
                        
                        HStack(spacing: 4) {
                            StarComponent(rating: 4)
                            Text(index.score)
                                .applyFont(font: .label1)
                        }
                    
                        Text(index.content)
                            .foregroundStyle(Color.neutral700)
                            .applyFont(font: .body2)
                            .lineLimit(index.more ? nil : 3)
                            .padding(.vertical, 12)
                        
                        Text(index.more ? "접기" : "더보기")
                            .foregroundStyle(Color.neutral600)
                            .applyFont(font: .body3)
                            .onTapGesture {
                                print("더보기")
                                index.more.toggle()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("신고")
                            .applyFont(font: .body3)
                            .foregroundStyle(Color.neutral300)
                            .onTapGesture {
                                print("신고")
                            }
                    }
                    .padding(.horizontal, 22)
                    
                    DivideRectangle(height: 1, color: Color.neutral50)
                        .opacity(index.id == data.last?.id ? 0 : 1)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                }
            }
        }
    }
}

#Preview {
    ReviewListView()
}

struct ReviewSampleData {
    let id = UUID().uuidString
    let user: String
    let star: String = "star.fill"
    let score: String = "4.7"
    let date: String = "2023.07.25"
    let content: String = "리뷰입니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는리뷰입니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는세줄까지노출합니다리뷰는"
    var more: Bool = false
    
    static let reivewSample = [
        ReviewSampleData(user: "user1"),
        ReviewSampleData(user: "user2"),
        ReviewSampleData(user: "user3"),
        ReviewSampleData(user: "user4"),
        ReviewSampleData(user: "user5"),
        ReviewSampleData(user: "user6"),
        ReviewSampleData(user: "user7"),
        ReviewSampleData(user: "user8"),
        ReviewSampleData(user: "user9"),
        ReviewSampleData(user: "user10"),
        ReviewSampleData(user: "user11"),
        ReviewSampleData(user: "user12"),
        ReviewSampleData(user: "user13"),
        ReviewSampleData(user: "user14")
    ]
}
