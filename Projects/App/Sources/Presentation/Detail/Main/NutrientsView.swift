//
//  NutrientsView.swift
//  App
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct NutrientsView: View {
//    let nutrients = [] // 영양성분 데이터 배열
    
    var body: some View {
        ForEach(0..<5) { index in
            HStack{
                Text("영양성분명1")
                Spacer()
                Text("영양성분")
            }
            .applyFont(font: .body2)
            .foregroundStyle(Color.neutral600)
            .padding(.vertical, 14)
            
            Rectangle()
                .fill(Color.neutral100)
                .frame(maxWidth: .infinity, maxHeight: 1)
                .opacity(index == 4 ? 0 : 1)
        }
    }
}

#Preview {
    NutrientsView()
}
