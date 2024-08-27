//
//  CategoryMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class CategoryMapper {
    static func toCategoryList(response: D1CategoryResponseDTO) -> D1CategoryResult {
        return D1CategoryResult(
            d1CategoryCode: response.d1CategoryCode ?? "",
            d1CategoryName: response.d1CategoryName ?? "",
            d2Category: (response.d2Category ?? []).compactMap { dto in
                guard let d2CategoryCode = dto.d2CategoryCode,
                      let d2CategoryName = dto.d2CategoryName,
                      let d2CategoryImage = dto.d2CategoryImage else {
                    return nil
                }
                return D2CategoryResult(
                    d2CategoryCode: d2CategoryCode,
                    d2CategoryName: d2CategoryName,
                    d2CategoryImage: d2CategoryImage,
                    noOptionYn: dto.noOptionYn
                )
            }
        )
    }
}


