//
//  NoneZeroView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct NoneZeroView: View {
    private let sample = ["영양성분1", "영양성분2", "영양성분3"]
    
    var body: some View {
        VStack {
            CommonTitle(title: "제로가 아닌 상품을 먹었다면?")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Rectangle()
                .fill(Color.neutral200)
                .frame(width: 116, height: 116)
 
            
            NutrientsView()
        }
        .padding(.init(top: 30, leading: 22, bottom: 6, trailing: 22))
        .background(Color.neutral50)
    }
}

#Preview {
    NoneZeroView()
}
