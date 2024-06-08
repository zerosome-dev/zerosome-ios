//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

struct CategoryMain: View {

    var body: some View {
        ScrollView {
            Text("카테고리")
            CategoryGridView(data: ZeroDrinkSampleData.dirnkType, type: "카페 음료",
                             last: false, pageSpacing: 22, gridSpacing: 17)
            CategoryGridView(data: ZeroDrinkSampleData.cafeType, type: "과자/아이스크림",
                             last: false, pageSpacing: 22, gridSpacing: 17)
            CategoryGridView(data: ZeroDrinkSampleData.snackType, type: "과자/아이스크림",
                             last: false, pageSpacing: 22, gridSpacing: 17)
            
            
            CategoryDetailView(data: ZeroDrinkSampleData.categoryDetail)
        }
    }
}

#Preview {
    CategoryMain()
}
