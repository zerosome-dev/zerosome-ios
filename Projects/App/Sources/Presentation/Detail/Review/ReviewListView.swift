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
    
    @EnvironmentObject var router: Router
    @State private var plus: Bool = false
    @State private var data = ReviewSampleData.reivewSample
    @State private var isAlert: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CommonButton(title: "리뷰 작성", font: .subtitle1)
                .tap {
                    router.navigateTo(.reviewList)
                }
                .padding(.horizontal, 22)
                .zIndex(1)
                
            ScrollView {
                ReviewScoreComponent(background: Color.neutral50,
                                     heightPadding: 38, radius: 8, review: "4.3", font: .review)
                .padding(.init(top: 10, leading: 22, bottom: 30, trailing: 22))
                
                LazyVStack(spacing: 0) {
                    ForEach($data, id: \.id) { $index in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                ZSText(index.user, fontType: .subtitle2, color: Color.neutral700)
                                Spacer()
                                ZSText(index.date, fontType: .body4, color: Color.neutral400)
                                
                            }
                            
                            HStack(spacing: 4) {
                                StarComponent(rating: 4)
                                ZSText(index.score, fontType: .label1)
                            }
                        
                            ZSText(index.content, fontType: .body2, color: Color.neutral700)
                                .lineLimit(index.more ? nil : 3)
                                .padding(.vertical, 12)
                            
                            ZSText(index.more ? "접기" : "더보기", fontType: .body3, color: Color.neutral600)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onTapGesture {
                                    index.more.toggle()
                                }
                            
                            ZSText("신고", fontType: .body3, color: Color.neutral300)
                                .onTapGesture {
                                    isAlert = true
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
        .scrollIndicators(.hidden)
        .ZSNavigationBackButtonTitle("상품 리뷰") {
            router.navigateBack()
        }
        .ZAlert(isShowing: $isAlert,
                type: .doubleButton(title: "신고할까요?", LButton: "닫기", RButton: "신고하기")) {
            isAlert = false
        } rightAction: {
            router.navigateTo(.report)
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
