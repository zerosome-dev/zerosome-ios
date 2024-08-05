//
//  NetworkError.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notConnected
    case response
    case decode
    case apiError
    case urlError
    case statusError
    case queryError
    case encode
    case badRequest
    case unknown
}
