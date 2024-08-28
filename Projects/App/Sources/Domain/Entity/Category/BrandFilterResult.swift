//
//  BrandFilterResult.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct BrandFilterResult: Identifiable {
    var brandCode: String
    var brandName: String
    
    var id: String {
        return brandCode
    }
}
