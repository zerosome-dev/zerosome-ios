//
//  ProductByCtgListResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

// 하위 카테고리별 상품 목록 조회
struct OffsetPageResponseDTO: Decodable {
    var content: [ProductByCtgResponseDTO]?
    var limit: Int?
    var offset: Int?
}

struct ProductByCtgResponseDTO: Decodable {
    var productId: Int?
    var image: String?
    var brandName: String?
    var productName: String?
    var rating: Double?
    var reviewCnt: Int?
}

//struct CtgOffsetPageResponseDTO: Decodable {
//    var content: [ProductByCtgResponseDTO]
//    var limit: Int
//    var offset: Int
//}
//
//struct ProductByCtgResponseDTO: Decodable {
//    var productId: Int
//    var image: String?
//    var brandName: String
//    var productName: String
//    var rating: Double?
//    var reviewCnt: Int
//}

