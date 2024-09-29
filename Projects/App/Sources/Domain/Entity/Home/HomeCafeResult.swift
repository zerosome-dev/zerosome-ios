//
//  HomeCafeResult.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeCafeResult: Identifiable {
    let id: Int
    let image: String
    let d1CategoryId: String
    let d2CategoryId: String
    let name: String
    let brand: String
    let review: Double
    let reviewCnt: Int
    
    init(
        id: Int,
        image: String,
        d1CategoryId: String,
        d2CategoryId: String,
        name: String,
        brand: String,
        review: Double,
        reviewCnt: Int
    ) {
        self.id = id
        self.image = image
        self.d1CategoryId = d1CategoryId
        self.d2CategoryId = d2CategoryId
        self.name = name
        self.brand = brand
        self.review = review
        self.reviewCnt = reviewCnt
    }
}
