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
}

struct UpdateBottomSheet: View {
    @ObservedObject var filterVM: CategoryFilteredViewModel
    
    var body: some View {
        VStack {
            ForEach(Update.allCases, id: \.self) { value in
                HStack(spacing: 2) {
                    Text(value.rawValue)
                    ZerosomeAsset.ic_check_black
                        .resizable()
                        .frame(width: 24, height: 24)
                        .opacity(filterVM.update == value ? 1 : 0)
                    
                    Spacer()
                }
                .onTapGesture {
                    filterVM.update = value
                    filterVM.updateToggle.toggle()
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
