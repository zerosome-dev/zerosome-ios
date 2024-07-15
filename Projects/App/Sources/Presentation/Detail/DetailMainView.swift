//
//  ProductDetailView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

class DetailMainViewModel: ObservableObject {
    @Published var isNutrients: Bool = false
    
}

struct DetailMainView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = DetailMainViewModel()
    
    private let storeSample = ["네이버", "쿠팡", "판매처", "티몬"]
    let rating: Int = 3 //Rating
    @State private var array: [String] = []
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.neutral50)
                .scaledToFit()

            VStack(spacing: 30) {
                ProductInfoView(rating: rating, reviewCnt: rating)
                
                DivideRectangle(height: 12, color: Color.neutral50)
                
                CommonTitle(title: "제품 영양 정보", type: .image, imageTitle: ZerosomeAsset.ic_arrow_after) {
                    viewModel.isNutrients = true
                }
                .padding(.horizontal, 22)
                .sheet(isPresented: $viewModel.isNutrients) {
                    NutrientsBottomSheet(viewModel: viewModel)
                        .presentationDetents([.height(710)])
                }
                
                DivideRectangle(height: 12, color: Color.neutral50)

                ChipsContainerView(array: $array, types: ZeroDrinkSampleData.data)
                    .padding(.horizontal, 22)
                OnlineStoreView()
                
                DivideRectangle(height: 12, color: Color.neutral50)
                
                DetailReviewView(reviewCounting: 5)
                
                DivideRectangle(height: 12, color: Color.neutral50)
                
                SimiliarProductView()
                CommonButton(title: "리뷰 작성", font: .subtitle2)
                    .padding(.horizontal, 22)
            }
        }
        .ZSNavigationBackButtonTitle("제품명") {
            router.navigateBack()
        }.scrollIndicators(.hidden)
    }
}

struct ProductInfoView: View {
    let rating: Int
    let reviewCnt: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("[브랜드명브랜드명브랜드명]")
                .applyFont(font: .body2)
                .foregroundStyle(Color.neutral500)
            Text("상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명")
                .applyFont(font: .subtitle1)
                .foregroundStyle(Color.neutral900)
                .lineLimit(1)
            
            DivideRectangle(height: 1, color: Color.neutral100)
            
            HStack(spacing: 6) {
                StarComponent(rating: rating)
                
                Text("(rating)")
                    .applyFont(font: .subtitle2)
                    .foregroundStyle(Color.neutral900)
                
                Rectangle()
                    .frame(width: 10,height: 1)
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(Color.neutral300)
                
                Text("(reviewCnt)개의 리뷰")
                    .applyFont(font: .body2)
                    .foregroundStyle(Color.neutral500)
            }
        }
        .padding(.horizontal, 22)
    }
}

struct OffLineStoreView: View {
    let data = ["네이버", "쿠팡", "판매처", "티몬"]
    
    var body: some View {
        CommonTitle(title: "오프라인 판매처", type: .solo)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 22)
        
        OfflineStoreComponent(offlineStore: data)
            .padding(.init(top: 0, leading: 22, bottom: 0, trailing: 47))
        
    }
}

struct OnlineStoreView: View {
    let data = ["네이버", "쿠팡", "판매처", "티몬"]
    
    var body: some View {
        VStack {
            CommonTitle(title: "온라인 판매처", type: .solo)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack(spacing: 10) {
                ForEach(data, id: \.self){ store in
                    HStack {
                        Text(store)
                            .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 0))
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral600)
                        Spacer()
                        
                        Text("바로가기")
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral400)
                            .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 16))
                            .onTapGesture {
                                print("온라인 판매처 바로가기")
                            }
                        
                    }
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    DetailMainView()
}
