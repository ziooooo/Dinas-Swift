//
//  DinasStructure.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class DinasStructure {
    
    var top: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .top))
    }
    
    var left: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .left))
    }
    
    var bottom: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .bottom))
    }
    
    var right: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .right))
    }
    
    var width: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .width))
    }
    
    var height: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .height))
    }
    
    var centerX: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .centerX))
    }
    
    var centerY: DinasStructure {
        return append(attribute: DinasFrameAttribute(type: .centerY))
    }
    
    var size: DinasStructure {
        return self.width.height
    }
    
    var center: DinasStructure {
        return self.centerX.centerY
    }
    
    var edges: DinasStructure {
        return self.top.left.bottom.right
    }
    
    
    @discardableResult
    func equalTo(_ target: DinasTargetProtocol) -> DinasStructure {
        return append(attribute: DinasEqualToAttribute(target: target))
    }
    
    @discardableResult
    func equalToSuperview() -> DinasStructure {
        return append(attribute: DinasEqualToAttribute(target: item!.superview!))
    }
    
    @discardableResult
    func multiplierBy(_ multiplier: CGFloat) -> DinasStructure {
        return append(attribute: DinasMultiplierAttribute(multiplier: multiplier))
    }
    
    func offset(_ offset: CGFloat) {
        append(attribute: DinasOffsetAttribute(offset: offset))
    }
    
    
    
    private weak var item: DinasView?
    
    init(item: DinasView?) {
        self.item = item
    }
    
    lazy var attributes = [DinasAttribute]()
    
    @discardableResult
    func append(attribute: DinasAttribute) -> DinasStructure {
        attributes.append(attribute)
        return self
    }
}
