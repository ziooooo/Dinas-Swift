//
//  DinasInstruction.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class DinasInstruction {
    
    var frameAttr: DinasFrameAttribute
    var equalToAttr: DinasEqualToAttribute?
    var multiplierAttr: DinasMultiplierAttribute?
    var offsetAttr: DinasOffsetAttribute?
    
    init(frameAttr: DinasFrameAttribute) {
        self.frameAttr = frameAttr
    }
}


extension DinasInstruction {
    var multiplier: CGFloat {
        return multiplierAttr?.multiplier ?? 1
    }
    var offset: CGFloat {
        return offsetAttr?.offset ?? 0
    }
    
}
