//
//  DetailUsecase.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import Combine

struct DetailUsecase {
    let detailRepoProtocol: DetailRepositoryProtocol
    
    func getProductDetail(productId: Int) -> Future<ProductDetailResponseResult, NetworkError> {
        return detailRepoProtocol.getProductDetail(productId)
    }
}
