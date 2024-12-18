//
//  MainData.swift
//  App
//
//  Created by 박서연 on 2024/09/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

enum MainData {
    case released
    case cafe
    
    var title: String {
        switch self {
        case .released:
            return "출시 예정 신상품"
        case .cafe:
            return "지금 핫한 카페 음료"
        }
    }
    
    var subtitle: String {
        switch self {
        case .released:
            return "출시 예정 및 최신 상품을 확인해 보세요"
        case .cafe:
            return "트렌디한 카페 음료를 지금 바로 확인해보세요"
        }
    }
}
