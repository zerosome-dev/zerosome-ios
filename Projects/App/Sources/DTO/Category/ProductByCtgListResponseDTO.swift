//
//  ProductByCtgListResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/22.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ProductByCtgListResponseDTO: Decodable {
    var orderType: String?
    var brandList: String?
    var zeroCtgList: String?
}

struct OffsetPageResponseDTO: Decodable {
    var content: [ProductByCtgResponse]?
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
