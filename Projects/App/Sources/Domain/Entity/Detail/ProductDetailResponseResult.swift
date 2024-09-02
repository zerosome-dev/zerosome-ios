//
//  ProductDetailResponseResult.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ProductDetailResponseResult: Decodable {
    var productId: Int
    var image: String
    var brandName: String
    var productName: Strig
    var nutrientList: [NutrientByPdtResult]
    var offlineStoreList: [OfflineStoreResult]
    var onlineStoreList: [OnlineStoreResult]
    var rating: Double
    var reviewCnt: Int
    var reviewThumbnailList: [ReviewThumbnailResult]
    var similarProductList: [SimilarProductResult]
}

struct NutrientByPdtResult: Decodable, Hashable {
    var nutrientName: String
    var servings: Double
    var amount: Double
    var servingsStandard: String
    var amountStandard: String
}

struct OfflineStoreResult: Decodable {
    var storeCode: String
    var storeName: String
}

struct OnlineStoreResult: Decodable {
    var storeCode: String
    var storeName: String
    var url: String
}

struct ReviewThumbnailResult: Decodable, Hashable {
    var reviewId: Int
    var rating: Double
    var reviewContents: String
    var regDate: String
}

struct SimilarProductResult: Decodable {
    var productId: Int
    var image: String
    var productName: String
    var brandName: String
    var rating: Double
    var reviewCnt: Int
}
