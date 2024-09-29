//
//  FilteredProductResult.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct OffsetFilteredProductResult {
    var content: [FilteredProductResult]
    var limit: Int
    var offset: Int
}

struct FilteredProductResult: Identifiable {
    var productId: Int
    var image: String
    var brandName: String
    var productName: String
    var rating: Double
    var reviewCnt: Int
    
    var id: String {
        return "\(productId)"
    }
}
