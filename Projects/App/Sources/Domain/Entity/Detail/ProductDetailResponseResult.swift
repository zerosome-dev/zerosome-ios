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

struct NutrientByPdtResult: Hashable {
    var nutrientName: String
    var servings: Double
    var amount: Double
    var servingsStandard: String
    var amountStandard: String
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

struct SimilarProductResult {
    var productId: Int
    var image: String
    var productName: String
    var brandName: String
    var rating: Double
    var reviewCnt: Int
}
