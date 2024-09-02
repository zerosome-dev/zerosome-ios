//
//  DetailRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/06.
//  Copyright © 2024 iOS. All rights reserved.
//

import Combine

protocol DetailRepositoryProtocol {
    func getProductDetail(_ productId: Int) async -> Future<ProductDetailResponseResult ,NetworkError>
}
