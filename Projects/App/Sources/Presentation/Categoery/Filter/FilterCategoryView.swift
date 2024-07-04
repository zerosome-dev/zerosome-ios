//
//  FilterCategoryView.swift
//  App
//
//  Created by 박서연 on 2024/07/03.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct FilterCategoryView: View {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    var body: some View {
        VStack {            
            CategoryGridComponent(data: ZeroDrinkSampleData.dirnkType, type: "카페 음료",
                                  last: true, pageSpacing: 22, gridSpacing: 17, duplicated: true)
            
            HStack {
                
            }
        }
    }
}

#Preview {
    FilterCategoryView(type: "생수/음료")
}
