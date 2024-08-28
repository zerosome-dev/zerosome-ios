//
//  CategoryMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class CategoryMapper {
    static func toCategoryResult(response: D1CategoryResponseDTO) -> D1CategoryResult {
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
    
    static func toBrandResult(response: BrandFilterResponseDTO) -> BrandFilterResult {
        return BrandFilterResult(
            brandCode: response.brandCode ?? "",
            brandName: response.brandName ?? ""
        )
    }
    
    static func toD2CategoryFilterResult(response: D2CategoryFilterResponseDTO) -> D2CategoryFilterResult {
        return D2CategoryFilterResult(
            d2CategoryCode: response.d2CategoryCode ?? "",
            d2CategoryName: response.d2CategoryName ?? "",
            noOptionYn: response.noOptionYn ?? false
        )
    }
    
    static func toZeoTagResult(response: ZeroCategoryFilterResponseDTO) -> ZeroCategoryFilterResult {
        return ZeroCategoryFilterResult(
            zeroCtgCode: response.zeroCtgCode ?? "",
            zeroCtgName: response.zeroCtgName ?? ""
        )
    }
}


