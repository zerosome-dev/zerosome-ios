//
//  Chipstype.swift
//  App
//
//  Created by 박서연 on 2024/07/12.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

public struct ChipsType: Equatable {
  let title: String
  let priority: Int
  
  public init(
    title: String,
    priority: Int = 0
  ) {
    self.title = title
    self.priority = priority
  }
  
  public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
    lhs.title == rhs.title
  }
}
