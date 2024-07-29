//
//  CategoryMain.swift
//  App
//
//  Created by 박서연 on 2024/06/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import DesignSystem
import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    @Published var isNutrients: Bool = false
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String = "전체"
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    @Published var tapData: String = ""
    
    var valuePublisher = PassthroughSubject<String, Never>()
    
    func updateSharedValue(newValue: String) {
        category = newValue
        valuePublisher.send(newValue)
    }
}

struct CategoryMainView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = CategoryViewModel()
    
    @State private var tapData: String = ""
    
    var body: some View {
        ScrollView {
            CategoryGridComponent(
                data: ZeroDrinkSampleData.drinkType,
                title: "생수/음료",
                last: false,
                after: true,
                tapData: $viewModel.category
            )
            .tapPageAction { router.navigateTo(.categoryFilter("생수/음료")) }
            .padding(.top, 20)
            
            CategoryGridComponent(
                data: ZeroDrinkSampleData.cafeType,
                title: "카페음료",
                last: false,
                after: true,
                tapData: $viewModel.category
            )
            .tapPageAction { router.navigateTo(.categoryFilter("카페음료")) }
            
            CategoryGridComponent(
                data: ZeroDrinkSampleData.snackType,
                title: "과자/아이스크림",
                last: true,
                after: true,
                tapData: $viewModel.category)
            .tapPageAction { router.navigateTo(.categoryFilter("과자/아이스크림")) }
        }
        .ZSnavigationTitle("카테고리")
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryMainView()
}
