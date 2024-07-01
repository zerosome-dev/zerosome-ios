//
//  NoneZeroView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct NoneZeroView: View {
    private let sample = ["영양성분1", "영양성분2", "영양성분3"]
    
    var body: some View {
        VStack {
            Text("제로가 아닌 상품을 먹었다면?")
                .applyFont(font: .heading2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .fill(Color.neutral200)
                .frame(width: 116, height: 116)
                .padding(.vertical, 32)
                .padding(.bottom, 54)
            
            LazyVStack(spacing: 10) {
                ForEach(sample, id: \.self) { index in
                    HStack {
                        Text(index)
                        Spacer()
                        Text(index)
                    }
                    .applyFont(font: .body2)
                    .foregroundStyle(Color.neutral600)
                    .padding(.vertical, 14)
                    
                    Rectangle()
                        .fill(Color.neutral50)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .opacity(index == sample.last! ? 0 : 1)
                }
                .padding(.bottom, 6)
            }
        }
        .padding(.top, 30)
        .background(Color.neutral50)
    }
}

#Preview {
    NoneZeroView()
}
