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
    @State private var array: [String] = []
    
    private let storeSample = ["네이버", "쿠팡", "판매처", "티몬"]
    let product: String
    let rating: Int = 3 //Rating
    
    init(product: String) {
        self.product = product
    }
    
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.neutral50)
                .scaledToFit()

            VStack(spacing: 30) {
                ProductInfoView(rating: rating, reviewCnt: rating)
                DivideRectangle(height: 12, color: Color.neutral50)
                
                CommonTitle(title: "제품 영양 정보", type: .image,
                            imageTitle: ZerosomeAsset.ic_arrow_after) {
                    viewModel.isNutrients = true
                }
                .padding(.horizontal, 22)
                .sheet(isPresented: $viewModel.isNutrients) {
                    NutrientsBottomSheet(viewModel: viewModel)
                        .presentationDetents([.height(710)])
                }
                
                DivideRectangle(height: 12, color: Color.neutral50)
                ChipsContainerView(array: $array, types: ZeroDrinkSampleData.data).padding(.horizontal, 22)
                
                OnlineStoreView()
                DivideRectangle(height: 12, color: Color.neutral50)
                DetailReviewView(reviewCounting: 5)
                    .tap {
                        router.navigateTo(.reviewList)
                    }
                DivideRectangle(height: 12, color: Color.neutral50)
                SimiliarProductView()
                CommonButton(title: "리뷰 작성", font: .subtitle2)
                    .padding(.horizontal, 22)
            }
        }
        .ZSNavigationBackButtonTitle(product) {
            router.navigateBack()
        }.scrollIndicators(.hidden)
    }
}

#Preview {
    DetailMainView(product: "제품명")
}
