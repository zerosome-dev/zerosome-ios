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
    
    @ObservedObject var viewModel: DetailMainViewModel
    let rows = Array(repeating: GridItem(.flexible()), count: 5)
    var action: (() -> Void)?
    
    init(
        viewModel: DetailMainViewModel,
        action: (() -> Void)? = nil
    
    ) {
        self.viewModel = viewModel
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if ((viewModel.dataInfo?.reviewCnt ?? 0) == 0) {
                CommonTitle(title: "아직 리뷰가 없어요", type: .solo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 62)
                NoneReviewView(action: action)
                    .padding(.bottom, 83)
            } else {
                VStack(spacing: 12) {
                    HStack {
                        ZSText("리뷰 \(viewModel.dataInfo?.reviewCnt ?? 0)", fontType: .heading2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 0) {
                            ZSText("더보기", fontType: .caption, color: Color.neutral700)
                            ZerosomeAsset.ic_arrow_after
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    }
                    .padding(.init(top: 0, leading: 22, bottom: 12, trailing: 22))
                    .onTapGesture {
                        action?()
                    }

                    VStack(spacing: 20) {
                        ReviewScoreComponent(
                            background: Color.neutral50,
                            heightPadding: 18,
                            radius: 8,
                            review: "\(viewModel.dataInfo?.rating ?? 0.0)",
                            font: .heading2
                        )
                        .padding(.horizontal, 22)
                        
                        ReviewCarouselView(
                            data: viewModel.dataInfo?.reviewThumbnailList ?? [],
                            viewModel: viewModel
                        )
                    }
                }
            }
        }
    }
}

extension DetailReviewView {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

#Preview {
    DetailReviewView(viewModel: DetailMainViewModel(detailUseCase: DetailUsecase(detailRepoProtocol: DetailRepository(apiService: ApiService()))))
}


