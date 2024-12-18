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
    var titleAction: (() -> Void)?
    
    init(
        viewModel: DetailMainViewModel,
        action: (() -> Void)? = nil,
        titleAction: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.action = action
        self.titleAction = titleAction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if ((viewModel.dataInfo?.reviewCnt ?? 0) == 0) {
                CommonTitle(title: "아직 리뷰가 없어요", type: .solo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 62)
                    .padding(.horizontal, 22)
                NoneReviewView(action: action, viewModel: viewModel)
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
                    .onTapGesture {
                        titleAction?()
                    }
                    .padding(.init(top: 0, leading: 22, bottom: 12, trailing: 22))
                    

                    VStack(spacing: 20) {
                        ReviewScoreComponent(
                            heightPadding: 18,
                            radius: 8,
                            review: viewModel.dataInfo?.rating ?? 0.0,
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
    
    func tapTitle(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.titleAction = action
        return copy
    }
}

#Preview {
    DetailReviewView(viewModel: DetailMainViewModel(detailUseCase: DetailUsecase(detailRepoProtocol: DetailRepository(apiService: ApiService()))))
}


