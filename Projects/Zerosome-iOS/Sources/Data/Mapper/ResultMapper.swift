//
//  ResultMapper.swift
//  App
//
//  Created by 박서연 on 2024/06/20.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ResultMapper<T: Decodable> {
    static func toMap(_ result: Result<Data, NetworkError>) -> Result<T, NetworkError> {
        switch result {
        case .success(let success):
            do {
                let data = try JSONDecoder().decode(T.self, from: success)
                return .success(data)
            } catch {
                return .failure(NetworkError.decode)
            }
        case .failure(let failure):
            return .failure(NetworkError.decode)
        }
    }
}
