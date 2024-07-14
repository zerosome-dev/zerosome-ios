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

}

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = CategoryViewModel()
    
    var body: some View {
        ScrollView {
            CategoryGridComponent(data: ZeroDrinkSampleData.drinkType, title: "생수/음료", last: false, after: true)
                .tapPageAction {
                    router.navigateTo(.categorySecondDepth("생수/음료"))
                }
                .tapAction {
                    router.navigateTo(.detailMainView)
                }
                .padding(.top, 20)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.cafeType,
                                  title: "카페음료",
                                  last: false,
                                  after: true)
            
            CategoryGridComponent(data: ZeroDrinkSampleData.snackType,
                                  title: "과자/아이스크림",
                                  last: true, 
                                  after: true)
        }
        .ZSnavigationTitle("카테고리")
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryMainView()
}
