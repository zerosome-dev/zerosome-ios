//
//  ProductDetailResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ProductDetailResponseDTO: Decodable {
    var productId: Int?
    var image: String?
    var brandName: String?
    var productName: String?
    var nutrientList: [NutrientByPdtDTO]?
    var offlineStoreList: [OfflineStoreDTO]?
    var onlineStoreList: [OnlineStoreDTO]?
    var rating: Double?
    var reviewCnt: Int?
    var reviewThumbnailList: [ReviewThumbnailDTO]?
    var similarProductList: [SimilarProductDTO]?
}

struct NutrientByPdtDTO: Decodable {
    var nutrientName: String?
    var servings: Double?
    var amount: Double?
    var servingsStandard: String?
    var amountStandard: String?
}

struct OfflineStoreDTO: Decodable {
    var storeCode: String?
    var storeName: String?
}

struct OnlineStoreDTO: Decodable {
    var storeCode: String?
    var storeName: String?
    var url: String?
}

struct ReviewThumbnailDTO: Decodable, Hashable {
    var reviewId: Int?
    var rating: Double?
    var reviewContents: String?
    var regDate: Date?
}

struct SimilarProductDTO: Decodable {
    var productId: Int?
    var image: String?
    var productName: String?
    var brandName: String?
    var rating: Double?
    var reviewCnt: Int?
}
