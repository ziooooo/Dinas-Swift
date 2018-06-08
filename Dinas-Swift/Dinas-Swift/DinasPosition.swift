//
//  DinasPosition.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

enum DinasPositionType: Int {
    case top = 0
    case left
    case bottom
    case right
    case width
    case height
    case centerX
    case centerY
}

struct DinasPosition {
    
    let item: DinasView
    let type: DinasPositionType

    init(item: DinasView, type: DinasPositionType) {
        self.item = item
        self.type = type
    }
}

extension DinasPosition {
    
}
