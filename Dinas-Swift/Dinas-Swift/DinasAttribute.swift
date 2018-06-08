//
//  DinasAttribute.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

enum DinasFrameAttributeType: Int {
    case top = 0
    case left
    case bottom
    case right
    case width
    case height
    case centerX
    case centerY
}

protocol DinasAttribute {}

struct DinasFrameAttribute: DinasAttribute {
    
    private(set) var type: DinasFrameAttributeType!
    
    init(type: DinasFrameAttributeType) {
        self.type = type
    }
}

struct DinasEqualToAttribute: DinasAttribute {
    
    private(set) var target: DinasTargetProtocol!
    
    init(target: DinasTargetProtocol) {
        self.target = target
    }
}

struct DinasMultiplierAttribute: DinasAttribute {
    
    private(set) var multiplier: CGFloat!
    
    init(multiplier: CGFloat) {
        self.multiplier = multiplier
    }
}


struct DinasOffsetAttribute: DinasAttribute {
    
    private(set) var offset: CGFloat!
    
    init(offset: CGFloat) {
        self.offset = offset
    }
}
