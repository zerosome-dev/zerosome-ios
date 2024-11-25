//
//  UpdateBottomSheetView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

enum Update: String, CaseIterable {
    case latest = "최신 등록순"
    case highStar = "별점 높은순"
    case lowStar = "별점 낮은순"
    case highReview = "리뷰 많은순"
    case lowReview = "리뷰 적은순"
    
    var orderType: String {
        switch self {
        case .latest:
            "RECENT"
        case .highStar:
            "REVIEWHIGH"
        case .lowStar:
            "REVIEWLOW"
        case .highReview:
            "REVIEWMANY"
        case .lowReview:
            "REVIEWFEW"
        }
    }
}

struct UpdateBottomSheet: View {
    @ObservedObject var viewModel: CategoryFilteredViewModel
    
    var body: some View {
        VStack {
            ForEach(Update.allCases, id: \.self) { value in
                HStack(spacing: 2) {
                    ZSText(value.rawValue, fontType: .subtitle2, color: viewModel.update == value ? .neutral900 : .neutral500)
                    ZerosomeAsset.ic_check_black
                        .resizable()
                        .frame(width: 24, height: 24)
                        .opacity(viewModel.update == value ? 1 : 0)
                    
                    Spacer()
                }
                .onTapGesture {
                    viewModel.update = value
                    viewModel.updateToggle.toggle()
                    viewModel.offset = 0 
                    viewModel.send(action: .getFilterResult)
                }
                .padding(.vertical, 12)
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
    }
}

//#Preview {
//    UpdateBottomSheet(filterVM: CategoryFilteredViewModel())
//}
