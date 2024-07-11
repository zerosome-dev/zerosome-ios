//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var category: String = ""
    @Published var update: Update = .latest
}

struct CategoryMainView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State private var test: Bool = false
    
    var body: some View {
        ScrollView {
                
            CategoryGridComponent(data: ZeroDrinkSampleData.drinkType,
                                  title: "카페 음료",
                                  last: false,
                                  duplicated: false,
                                  total: true)
            .padding(.top, 20)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.cafeType,
                                  title: "과자/아이스크림",
                                  last: false,
                                  duplicated: false,
                                  total: true)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.snackType,
                                  title: "과자/아이스크림",
                                  last: true, 
                                  duplicated: false,
                                  total: false)
        }
        .ZSnavigationTitle("카테고리")
    }
}

#Preview {
    CategoryMainView()
}
