//
//  DetailMapper.swift
//  App
//
//  Created by 박서연 on 2024/09/02.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class DetailMapper {
    static func toDetailResult(response: ProductDetailResponseDTO) -> ProductDetailResponseResult {
        return ProductDetailResponseResult(
            productId: response.productId ?? 0,
            image: response.image ?? "" ,
            brandName: response.brandName ?? "",
            productName: response.productName ?? "",
            nutrientList: (response.nutrientList ?? []).map({ dto in
                NutrientByPdtResult(
                    nutrientName: dto.nutrientName ?? "",
                    percentageUnit: dto.percentageUnit ?? "",
                    amount: dto.amount ?? 0.0,
                    percentage: dto.percentage ?? 0.0,
                    amountUnit: dto.amountUnit ?? ""
                )
            }),
            offlineStoreList: (response.offlineStoreList ?? []).map({ dto in
                OfflineStoreResult(
                    storeCode: dto.storeCode ?? "",
                    storeName: dto.storeName ?? ""
                )
            }),
            onlineStoreList: (response.onlineStoreList ?? []).map({ dto in
                OnlineStoreResult(
                    storeCode: dto.storeCode ?? "",
                    storeName: dto.storeName ?? "",
                    url: dto.url ?? ""
                )
            }),
            rating: response.rating ?? 0.0,
            reviewCnt: response.reviewCnt ?? 0,
            reviewThumbnailList: (response.reviewThumbnailList ?? []).map({ dto in
                ReviewThumbnailResult(
                    reviewId: dto.reviewId ?? 0,
                    rating: dto.rating ?? 0.0,
                    reviewContents: dto.reviewContents ?? "",
                    regDate: dto.regDate ?? ""
                )
            }),
            similarProductList: (response.similarProductList ?? []).map({ dto in
                SimilarProductResult(
                    productId: dto.productId ?? 0,
                    image: dto.image ?? "",
                    productName: dto.productName ?? "",
                    brandName: dto.brandName ?? "",
                    rating: dto.rating ?? 0.0,
                    reviewCnt: dto.reviewCnt ?? 0)
            }))
    }
}
