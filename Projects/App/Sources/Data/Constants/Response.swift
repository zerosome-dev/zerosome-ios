//
//  Response.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let code: String
    let status: Bool
    let data: T?
}

struct NoneDecodeResponse: Decodable { }
