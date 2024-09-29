//
//  DateFormatter.swift
//  App
//
//  Created by 박서연 on 2024/09/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

class DateMapper {
    static func returnDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy.MM.dd"
        let formattedDateString = displayFormatter.string(from: date)
        return formattedDateString
    }
}
