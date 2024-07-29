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
    
    @ObservedObject var viewModel: CategoryViewModel
    
    public var body: some View {
        VStack {
            CommonTitle(title: "제품 영양 정보",
                        type: .image,
                        imageTitle: ZerosomeAsset.ic_xmark) {
                viewModel.isNutrients = false
            }
            .padding(.bottom, 20)
            .padding(.top, 30)
            
            HStack {
                Text("100ml 당")
                Spacer()
                Text("(어쩌구저쩌구)kcal")
            }
            .foregroundStyle(Color.neutral600)
            .applyFont(font: .body2)
            .padding(14)
            .background(Color.neutral50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom, 6)
            
            ScrollView {
                ForEach(0..<20) { index in
                    HStack{
                        Text("영양성분명1")
                        Spacer()
                        Text("영양성분")
                    }
                    .applyFont(font: .body2)
                    .foregroundStyle(Color.neutral600)
                    .padding(.vertical, 14)
//                    
                    Rectangle()
                        .fill(Color.neutral100)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .opacity(index == 20 ? 0 : 1)
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NutrientsBottomSheet(viewModel: CategoryViewModel())
}
