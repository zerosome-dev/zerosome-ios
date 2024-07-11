//
//  CategoryBottomSheet.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CategoryBottomSheet: View {
    
    @ObservedObject var viewModel = CategoryViewModel()
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
    
    var body: some View {
        GeometryReader { geomtery in
            let width = geomtery.size.width / 3
            
            VStack(spacing: 21) {
                HStack {
                    Text("생수/음료")
                        .applyFont(font: .heading2)
                    Spacer()
                    Text("중복 선택 불가")
                        .applyFont(font: .body3)
                        .foregroundStyle(Color.neutral500)
                }
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ZeroDrinkSampleData.drinkType, id: \.self) { type in
                        VStack(spacing: 6) {
                            Rectangle()
                                .fill(Color.neutral50)
                                .frame(width: size, height: size)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay {
                                    if viewModel.category == type {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.primaryFF6972)
                                    }
                                }
                            Text(type)
                                .foregroundStyle(Color.neutral900)
                                .applyFont(font: .body2)
                        }
                        .onTapGesture {
                            type == viewModel.category ? (viewModel.category = "") : (viewModel.category = type)
                        }
                    }
                }
                
                Spacer()
                HStack(spacing: 12) {
                    Text("초기화")
                        .frame(height: 52)
                        .frame(maxWidth: width)
                        .background(Color.neutral100)
                        .foregroundStyle(Color.neutral300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            viewModel.category = ""
                        }
                    
                    CommonButton(title: "확인", font: .subtitle1)
                        .enable(!viewModel.category.isEmpty)
                        .frame(maxWidth: width * 2)
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
    }
}

#Preview {
    CategoryBottomSheet()
}

/*
 
 public let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
 public let size = (UIScreen.main.bounds.width - (17 * 3) - 44) / 4
 public let data: [String]
 
 public init(data: [String]) {
     self.data = data
 }
 
 public var body: some View {
     LazyVGrid(columns: columns, spacing: 20) {
         ForEach(data, id: \.self) { type in
             VStack(spacing: 6) {
                 Rectangle()
                     .fill(Color.neutral50)
                     .frame(width: size, height: size)
                     .clipShape(RoundedRectangle(cornerRadius: 8))
                 Text(type)
                     .foregroundStyle(Color.neutral900)
                     .applyFont(font: .body2)
                     
             }
         }
     }
 }
 */
