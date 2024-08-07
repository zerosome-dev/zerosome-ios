//
//  ProductDetailView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Kingfisher

class DetailMainViewModel: ObservableObject {
    
    enum Action {
        case fetchData
        case tapNutrients
        case moreReview
        case writeReview
    }
    
    @Published var dataInfo: ProductDetailResponseDTO?
    @Published var productId: Int = 0
    @Published var isNutrients: Bool = false
    
    private let detailUseCase: DetailUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        detailUseCase: DetailUsecase
    ) {
        self.detailUseCase = detailUseCase
    }
    
    func send(action: Action) {
        switch action {
        case .fetchData:
            Task {
                await detailUseCase.getProductDetail(productId: productId)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let failure):
                            debugPrint("🧪 Fetch Product Detail Failure \(failure.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] data in
                        self?.dataInfo = data
//                        print("😈✳️ \(self.dataInfo)")
                    })
                    .store(in: &cancellables)
            }
        case .tapNutrients:
            print("영양성분")
        case .moreReview:
            print("리뷰 더보기")
        case .writeReview:
            print("리뷰 작성하기")
        }
    }
}

struct DetailMainView: View {

    private let storeSample = ["네이버", "쿠팡", "판매처", "티몬"]
    let productId: Int
    
    @State private var array: [String] = []
    @EnvironmentObject var router: Router
    
    @StateObject private var viewModel = DetailMainViewModel(
        detailUseCase: DetailUsecase(
            detailRepoProtocol: DetailRepository(
                apiService: ApiService()
            )
        )
    )
    
    init(productId: Int) {
        self.productId = productId
    }
    
    var body: some View {
        GeometryReader { geomtry in
            let size = geomtry.size
            ScrollView {
                KFImage(URL(string: viewModel.dataInfo?.image ?? ""))
                    .placeholder {
                        ProgressView()
                            .tint(Color.primaryFF6972)
                    }
                    .resizable()
                    .frame(width: size.width, height: size.width)

                VStack(spacing: 30) {
                    ProductInfoView(
                        name: viewModel.dataInfo?.productName ?? "",
                        brand: viewModel.dataInfo?.brandName ?? "",
                        rating: viewModel.dataInfo?.rating ?? 0.0,
                        reviewCnt: viewModel.dataInfo?.reviewCnt ?? 0
                    )
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
                    
                    OffLineStoreView(offlineStore: viewModel.dataInfo?.offlineStoreList ?? [])
                    OnlineStoreView(onlineStore: viewModel.dataInfo?.onlineStoreList ?? [])
                    
                    DivideRectangle(height: 12, color: Color.neutral50)
                    DetailReviewView(reviewCounting: viewModel.dataInfo?.reviewCnt ?? 0)
                        .tap {
                            router.navigateTo(.reviewList)
                        }
                    DivideRectangle(height: 12, color: Color.neutral50)
                    
                    SimiliarProductView(viewModel: viewModel)
                    CommonButton(title: "리뷰 작성", font: .subtitle2)
                        .padding(.horizontal, 22)
                }
            }
        }
        .onAppear {
            viewModel.productId = productId
            viewModel.send(action: .fetchData)
        }
        .ZSNavigationBackButtonTitle(viewModel.dataInfo?.productName ?? "") {
            router.navigateBack()
        }.scrollIndicators(.hidden)
    }
}

#Preview {
    DetailMainView(productId: 167)
}
