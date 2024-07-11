//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

struct CategoryMainView: View {
    @State private var test: Bool = false
    
    var body: some View {
        ScrollView {
//            CategoryDetailView(data: ZeroDrinkSampleData.categoryDetail)
//                .padding(.horizontal, 22)
//                .onTapGesture {
//                    test.toggle()
//                }
                
            CategoryGridComponent(data: ZeroDrinkSampleData.drinkType,
                                  type: "카페 음료",
                                  last: false,
                                  pageSpacing: 22,
                                  gridSpacing: 17,
                                  duplicated: false).padding(.top, 20)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.cafeType,
                                  type: "과자/아이스크림",
                                  last: false,
                                  pageSpacing: 22,
                                  gridSpacing: 17,
                                  duplicated: false)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.snackType,
                                  type: "과자/아이스크림",
                                  last: false,
                                  pageSpacing: 22,
                                  gridSpacing: 17,
                                  duplicated: false)
        }
        .ZSnavigationTitle("카테고리")
    }
}

#Preview {
    CategoryMainView()
}
