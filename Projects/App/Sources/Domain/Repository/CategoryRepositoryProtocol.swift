//
//  CategoryRepositoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import Combine

protocol CategoryRepositoryProtocol {
    func getCategoryList() -> Future<[D1CategoryResult], NetworkError>
}
