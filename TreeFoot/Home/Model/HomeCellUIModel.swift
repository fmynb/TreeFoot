//
//  HomeCellUIModel.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation

import HandyJSON
struct HomeCellUIModel {
    
}

// MARK: - Welcome
struct Welcome: HandyJSON {
    
    let code: Int = 0
    let data: DataClass = DataClass()
}

// MARK: - DataClass
struct DataClass: HandyJSON {
    
    let eats = [Eat]()
    let dayRecommend = [DayRecommend]()
    let paln = [Paln]()
    let suggest = [Suggest]()
    let fav = [Fav]()
    let mealdetail = [Mealdetail]()
    let dayRecommendmore = [DayRecommendmore]()
    let supplement = [Supplement]()
    let favmore = [FavMore]()
}

// MARK: - DayRecommend
struct DayRecommend: HandyJSON {

    let name = ""
    let descrption: String = ""
    let toUse = [String]()
    let img = ""
    
    enum CodingKeys: String, CodingKey {
        case name, descrption
        case toUse = "to_use"
    }
}

// MARK: - Eat
struct Eat: HandyJSON {
    
    let img = ""
    let name: String = ""
    let content = [Content]()
}

// MARK: - Content
struct Content: HandyJSON {
    
    let name = ""
    let image = ""
    let kaluli: String = ""
}

// MARK: - Paln
struct Paln: HandyJSON {
    
    let name: String = ""
    let star: Int = 5
    let content = [Suggest]()
}

// MARK: - Suggest
struct Suggest: HandyJSON {
    
    let name = ""
    let descrption = ""
    let use = ""
    let tips: String = ""
    let star = 1
    let img = ""
}

// MARK: - Suggest
struct Fav: HandyJSON {
    
    let name = ""
    let descrption = ""
    let use = ""
    let img = ""
}

// MARK: - mealDetail
struct Mealdetail: HandyJSON {
    
    let name = ""
    let materialslabel: String = ""
    let img = ""
}
// MARK: - DayRecommendmore
struct DayRecommendmore:HandyJSON {
    let name:String = ""
    let img:String = ""
}

// MARK: - supplement
struct Supplement: HandyJSON {
    
    let name = ""
    let introduce: String = ""
    let standarduseway: String = ""
    let attention: String = ""
    let img = ""
}
// MARK: - favmore
struct FavMore:HandyJSON{
    let name:String = ""
    let img:String = ""
}
