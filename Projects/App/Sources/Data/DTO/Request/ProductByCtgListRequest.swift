//
//  ProductByCtgListRequest.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ProductByCtgListRequest: Encodable {
    var orderType: String?
    var brandList: [String]?
    var zeroCtgList: [String]?
}
