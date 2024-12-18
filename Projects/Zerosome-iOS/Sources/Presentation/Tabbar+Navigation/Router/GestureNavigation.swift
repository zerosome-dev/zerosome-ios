//
//  GestureNavigation.swift
//  App
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
