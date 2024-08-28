//
//  D2CategoryFilterResult.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct D2CategoryFilterResult: Identifiable {
    var d2CategoryCode: String
    var d2CategoryName: String
    var noOptionYn: Bool
    
    var id: String {
        return d2CategoryCode
    }
}
