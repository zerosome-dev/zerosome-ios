//
//  FilterMapper.swift
//  App
//
//  Created by 박서연 on 2024/08/29.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class FilterMapper {
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
            noOptionYn: response.noOptionYn ?? false,
            d2CategoryImage: response.d2CategoryImage ?? ""
        )
    }
    
    static func toZeroTagResult(response: ZeroCategoryFilterResponseDTO) -> ZeroCategoryFilterResult {
        return ZeroCategoryFilterResult(
            zeroCtgCode: response.zeroCtgCode ?? "",
            zeroCtgName: response.zeroCtgName ?? ""
        )
    }
    
    static func toFilteredProductResult(response: OffsetPageResponseDTO) -> OffsetFilteredProductResult {
        let content = (response.content ?? []).map { productDTO in
            FilteredProductResult(
                productId: productDTO.productId ?? 0,
                image: productDTO.image ?? "",
                brandName: productDTO.brandName ?? "",
                productName: productDTO.productName ?? "",
                rating: productDTO.rating ?? 0.0,
                reviewCnt: productDTO.reviewCnt ?? 0
            )
        }
        
        return OffsetFilteredProductResult(
            content: content,
            limit: response.limit ?? 0,
            offset: response.offset ?? 0
        )
    }
}
