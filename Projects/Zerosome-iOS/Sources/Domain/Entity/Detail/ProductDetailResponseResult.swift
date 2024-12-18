//
//  ProductDetailResponseResult.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ProductDetailResponseResult {
    var productId: Int
    var image: String
    var brandName: String
    var productName: String
    var nutrientList: [NutrientByPdtResult]
    var offlineStoreList: [OfflineStoreResult]
    var onlineStoreList: [OnlineStoreResult]
    var rating: Double
    var reviewCnt: Int
    var reviewThumbnailList: [ReviewThumbnailResult]
    var similarProductList: [SimilarProductResult]
}

struct NutrientByPdtResult: Hashable, Identifiable {
    var nutrientName: String
    var percentageUnit: String
    var amount: Float
    var percentage: Float
    var amountUnit: String
    
    var id = UUID().uuidString
}

struct OfflineStoreResult: Identifiable, Equatable {
    var storeCode: String
    var storeName: String
    
    var id: String {
        return storeCode
    }
}

struct OnlineStoreResult {
    var storeCode: String
    var storeName: String
    var url: String
}

struct ReviewThumbnailResult: Identifiable, Hashable {
    var reviewId: Int
    var rating: Double
    var reviewContents: String
    var regDate: String
    
    var id: String {
        return String(reviewId)
    }
}

struct SimilarProductResult: Identifiable {
    var productId: Int
    var image: String
    var productName: String
    var brandName: String
    var rating: Double
    var reviewCnt: Int
    
    var id: String {
        return "\(productId)"
    }
}
