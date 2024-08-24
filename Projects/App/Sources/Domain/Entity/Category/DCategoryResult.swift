//
//  DCategoryResult.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct D1CategoryResult: Identifiable, Decodable {
    let d1CategoryCode: String
    let d1CategoryName: String
    let d2Category: [D2CategoryResult]
    
    var id: String {
        return d1CategoryCode
    }
}

struct D2CategoryResult: Identifiable, Decodable {
    let d2CategoryCode: String
    let d2CategoryName: String
    let d2CategoryImage: String
    let noOptionYn: Bool // D2카테고리 > 전체 > noOption = true
    
    var id: String {
        return d2CategoryCode
    }
}
