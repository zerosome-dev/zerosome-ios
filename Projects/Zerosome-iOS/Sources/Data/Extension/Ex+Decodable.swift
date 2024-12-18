//
//  Ex+Decodable.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import UIKit

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        return dictionary as? [String: Any] ?? [:]
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
