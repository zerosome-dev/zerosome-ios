//
//  SampleData.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

public struct ZeroDrinkSampleData {
    public var photo: String
    
    public static let data = [
        ZeroDrinkSampleData(photo: ZeroDrinkSampleData.url1),
        ZeroDrinkSampleData(photo: ZeroDrinkSampleData.url2)
    ]
    public static let url1 = "https://img.hankyung.com/photo/202303/AKR20230313020200003_01_i_P4.jpg"
    public static let url2 = "https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/3hwo/image/QeM1ma7-zuUrwCi1qk4xcX0ODxg.PNG"
    
    public static let dirnkType = ["탄산수", "탄산음료", "커피음료", "차음료", "어린이음료", "이온음료"]
    public static let cafeType = ["스타벅스", "메카커피", "빽다방", "투썸플레이스"]
    public static let snackType = ["과자", "아이스크림"]
    public static let categoryDetail = ["카테고리", "브랜드", "최신순", "태그2"]
}
