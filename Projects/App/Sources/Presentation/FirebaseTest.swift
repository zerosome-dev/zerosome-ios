//
//  FirebaseTest.swift
//  App
//
//  Created by 박서연 on 2024/09/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct FirebaseTest: View {
    var body: some View {
        Text("실험용")
            .onTapGesture {
                print("test tapped")
                Analytics.logEvent("SYTEST", parameters: nil)
            }
    }
}

#Preview {
    FirebaseTest()
}
