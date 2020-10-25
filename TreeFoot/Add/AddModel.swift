//
//  AddModel.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/24.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation
import HandyJSON

// MARK: - DataClass
struct AddModel: HandyJSON {
    let eats = [AddFood]()
}


// MARK: - AddFood
struct AddFood: HandyJSON {
    var categoryName = ""
    var content = [Ingredient]()
}
