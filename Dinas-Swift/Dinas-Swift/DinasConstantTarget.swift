//
//  DinasConstantTarget.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

protocol DinasConstantTarget {
}

extension Int: DinasConstantTarget {
}

extension UInt: DinasConstantTarget {
}

extension Float: DinasConstantTarget {
}

extension Double: DinasConstantTarget {
}

extension CGFloat: DinasConstantTarget {
}

extension CGSize: DinasConstantTarget {
}

extension CGPoint: DinasConstantTarget {
}

extension DinasConstantTarget {
    func dinasConstantTargetValueFor(instruction: DinasInstruction) -> CGFloat {
        
        if let value = self as? CGFloat {
            return value
        }
        
        if let value = self as? Float {
            return CGFloat(value)
        }
        
        if let value = self as? Double {
            return CGFloat(value)
        }
        
        if let value = self as? Int {
            return CGFloat(value)
        }
        
        if let value = self as? UInt {
            return CGFloat(value)
        }
        
        let attrType = instruction.frameAttr.type!
        
        if let value = self as? CGSize {
            if attrType == .width {
                return value.width
            } else if attrType == .height {
                return value.height
            } else {
                assert(false, "你想弄啥？")
            }
        }
        
        if let value = self as? CGPoint {
            switch attrType {
            case .left, .right, .centerX: do {
                return value.x
                }
            case .top, .bottom, .centerY: do {
                return value.y
                }
            default: do {
                }
            }
        }
        
        return 0.0
    }
}
