//
//  NutrientsBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/04.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct NutrientsBottomSheet: View {
    
    @ObservedObject var viewModel: DetailMainViewModel
    
    public var body: some View {
        VStack {
            CommonTitle(
                title: "제품 영양 정보",
                type: .image,
                imageTitle: ZerosomeAsset.ic_xmark
            )
            .imageAction { viewModel.isNutrients = false }
            .padding(.vertical, 24)
            
            if viewModel.nutrientEnity.isEmpty {
                VStack {
                    ProgressView()
                        .tint(.primaryFF6972)
                        .frame(width: 30, height: 30)
                    ZSText("준비중입니다", fontType: .subtitle1)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
            } else {
                VStack(spacing: 6) {
                    HStack {
                        ZSText("100ml당", fontType: .body2, color: .neutral600)
                        Spacer()
                        ZSText("(어쩌구저쩌구)kcal", fontType: .body2, color: .neutral600)
                    }
                    .padding(14)
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    ScrollView {
                        let count = viewModel.nutrientEnity.count
                        
                        ForEach(0..<count, id: \.self) { index in
                            HStack{
                                Text(viewModel.nutrientEnity[index].nutrientName)
                                Spacer()
                                Text("\(viewModel.nutrientEnity[index].amountStandard)g \(viewModel.nutrientEnity[index].servingsStandard)kcal")
                            }
                            .applyFont(font: .body2)
                            .foregroundStyle(Color.neutral600)
                            .padding(.vertical, 14)
                            
                            Rectangle()
                                .fill(Color.neutral100)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .opacity(count-1 == index ? 0 : 1)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

//#Preview {
//    NutrientsBottomSheet(viewModel: DetailMainViewModel())
//}
