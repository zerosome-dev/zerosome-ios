//
//  CategoryFilteredViewModel.swift
//  App
//
//  Created by 박서연 on 2024/07/15.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class CategoryFilteredViewModel: ObservableObject {
    @Published var updateToggle: Bool = false
    @Published var update: Update = .latest
    
    @Published var category: String?
    @Published var zeroTag: [String] = []
    @Published var brand: [String] = []
    
    @Published var sheetToggle: CategoryDetail? = nil
    
    init(category: String? = nil) {
        self.category = category
    }
}
