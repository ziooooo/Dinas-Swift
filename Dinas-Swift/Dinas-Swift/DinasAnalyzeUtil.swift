//
//  DinasAnalyzeUtil.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

let DIN_X_ANALYZE_KEY = "DIN_X_ANALYZE_KEY"
let DIN_Y_ANALYZE_KEY = "DIN_Y_ANALYZE_KEY";
let DIN_W_ANALYZE_KEY = "DIN_W_ANALYZE_KEY";
let DIN_H_ANALYZE_KEY = "DIN_H_ANALYZE_KEY";

let DIN_TOP_KEY      =   "DIN_TOP_KEY";
let DIN_LEFT_KEY     =   "DIN_LEFT_KEY";
let DIN_BOTTOM_KEY   =   "DIN_BOTTOM_KEY";
let DIN_RIGHT_KEY    =   "DIN_RIGHT_KEY";
let DIN_WIDTH_KEY    =   "DIN_WIDTH_KEY";
let DIN_HEIGHT_KEY   =   "DIN_HEIGHT_KEY";
let DIN_CENTERX_KEY  =   "DIN_CENTERX_KEY";
let DIN_CENTERY_KEY  =   "DIN_CENTERY_KEY";



struct DinasAnalyzeUtil {
    
    static func analyze(attributes: [DinasAttribute]) -> [String:[String:DinasInstruction]] {
        
        var insTransfer = [DinasInstruction]()
        var insResultArr = [DinasInstruction]()
        
        var describeEnd = false
        
        for attr in attributes {
            if let attr = attr as? DinasFrameAttribute {
                if describeEnd {
                    insResultArr.append(contentsOf: insTransfer)
                    insTransfer.removeAll()
                }
                describeEnd = false
                
                let instrction = DinasInstruction(frameAttr: attr)
                insTransfer.append(instrction)
            }
            else {
                describeEnd = true
                
                for ins in insTransfer {
                    if let attr = attr as? DinasEqualToAttribute {
                        ins.equalToAttr = attr
                    }
                    else if let attr = attr as? DinasMultiplierAttribute {
                        ins.multiplierAttr = attr
                    }
                    else if let attr = attr as? DinasOffsetAttribute {
                        ins.offsetAttr = attr
                    }
                }
            }
        }
        if describeEnd {
            insResultArr.append(contentsOf: insTransfer)
            insTransfer.removeAll()
        }
        
        var insXArr = [DinasInstruction]()
        var insYArr = [DinasInstruction]()
        var insWArr = [DinasInstruction]()
        var insHArr = [DinasInstruction]()
        
        for ins in insResultArr {
            switch ins.frameAttr.type {
            case .left, .right, .width, .centerX: do {
                insXArr.append(ins)
                insWArr.append(ins)
                }
            case .top, .bottom, .height, .centerY: do {
                insYArr.append(ins)
                insHArr.append(ins)
                }
            default: do {
                }
            }
        }
        
        var insXDic = [String:DinasInstruction]()
        var insYDic = [String:DinasInstruction]()
        var insWDic = [String:DinasInstruction]()
        var insHDic = [String:DinasInstruction]()
        
        
        //x
        xfor: for ins in insXArr {
            switch ins.frameAttr.type {
            case .left: do {
                insXDic[DIN_LEFT_KEY] = ins
                break xfor
                }
            case .width: do {
                for subIns in insXArr {
                    if subIns.frameAttr.type == .centerX
                        || subIns.frameAttr.type == .right {
                        insXDic[DIN_WIDTH_KEY] = ins
                        if subIns.frameAttr.type == .centerX {
                            insXDic[DIN_CENTERX_KEY] = subIns
                        }
                        else {
                            insXDic[DIN_RIGHT_KEY] = subIns
                        }
                        break xfor
                    }
                }
                }
            case .right: do {
                for subIns in insXArr {
                    if subIns.frameAttr.type == .centerX
                        || subIns.frameAttr.type == .width {
                        insXDic[DIN_RIGHT_KEY] = ins
                        if subIns.frameAttr.type == .centerX {
                            insXDic[DIN_CENTERX_KEY] = subIns
                        }
                        else {
                            insXDic[DIN_WIDTH_KEY] = subIns
                        }
                        break xfor
                    }
                }
                }
            default: do {
                }
            }
        }
        
        //y
        yfor: for ins in insYArr {
            switch ins.frameAttr.type {
            case .top: do {
                insYDic[DIN_TOP_KEY] = ins
                break yfor
                }
            case .height: do {
                for subIns in insYArr {
                    if subIns.frameAttr.type == .centerY
                        || subIns.frameAttr.type == .bottom {
                        insYDic[DIN_HEIGHT_KEY] = ins
                        if subIns.frameAttr.type == .centerY {
                            insYDic[DIN_CENTERY_KEY] = subIns
                        }
                        else {
                            insYDic[DIN_BOTTOM_KEY] = subIns
                        }
                        break yfor
                    }
                }
                }
            case .bottom: do {
                for subIns in insYArr {
                    if subIns.frameAttr.type == .centerY
                        || subIns.frameAttr.type == .height {
                        insYDic[DIN_BOTTOM_KEY] = ins
                        if subIns.frameAttr.type == .centerY {
                            insYDic[DIN_CENTERY_KEY] = subIns
                        }
                        else {
                            insYDic[DIN_HEIGHT_KEY] = subIns
                        }
                        break yfor
                    }
                }
                }
            default: do {
                }
            }
        }
        
        //w
        wfor: for ins in insWArr {
            switch ins.frameAttr.type {
            case .width: do {
                insWDic[DIN_WIDTH_KEY] = ins
                break wfor
                }
            case .left: do {
                for subIns in insWArr {
                    if subIns.frameAttr.type == .centerX
                        || subIns.frameAttr.type == .right {
                        insWDic[DIN_LEFT_KEY] = ins
                        if subIns.frameAttr.type == .centerX {
                            insWDic[DIN_CENTERX_KEY] = subIns
                        }
                        else {
                            insWDic[DIN_RIGHT_KEY] = subIns
                        }
                        break wfor
                    }
                }
                }
            case .right: do {
                for subIns in insWArr {
                    if subIns.frameAttr.type == .centerX
                        || subIns.frameAttr.type == .left {
                        insWDic[DIN_RIGHT_KEY] = ins
                        if subIns.frameAttr.type == .centerX {
                            insWDic[DIN_CENTERX_KEY] = subIns
                        }
                        else {
                            insWDic[DIN_LEFT_KEY] = subIns
                        }
                        break wfor
                    }
                }
                }
            default: do {
                }
            }
        }
        
        //h
        hfor: for ins in insHArr {
            switch ins.frameAttr.type {
            case .height: do {
                insHDic[DIN_HEIGHT_KEY] = ins
                break hfor
                }
            case .top: do {
                for subIns in insHArr {
                    if subIns.frameAttr.type == .centerY
                        || subIns.frameAttr.type == .bottom {
                        insHDic[DIN_TOP_KEY] = ins
                        if subIns.frameAttr.type == .centerY {
                            insHDic[DIN_CENTERY_KEY] = subIns
                        }
                        else {
                            insHDic[DIN_BOTTOM_KEY] = subIns
                        }
                        break hfor
                    }
                }
                }
            case .bottom: do {
                for subIns in insHArr {
                    if subIns.frameAttr.type == .centerY
                        || subIns.frameAttr.type == .top {
                        insHDic[DIN_BOTTOM_KEY] = ins
                        if subIns.frameAttr.type == .centerY {
                            insHDic[DIN_CENTERY_KEY] = subIns
                        }
                        else {
                            insHDic[DIN_TOP_KEY] = subIns
                        }
                        break hfor
                    }
                }
                }
            default: do {
                }
            }
        }
        
        let resultDic = [DIN_X_ANALYZE_KEY:insXDic,
                         DIN_Y_ANALYZE_KEY:insYDic,
                         DIN_W_ANALYZE_KEY:insWDic,
                         DIN_H_ANALYZE_KEY:insHDic]
        
        return resultDic
        
    }
    
    static func execute(instruction: DinasInstruction, to view: DinasView) -> CGFloat {
        
        guard let target = instruction.equalToAttr?.target else {
            assert(false, "少了点啥吧")
            return 0
        }
        
        if let target = target as? DinasConstantTarget {
            return target.dinasConstantTargetValueFor(instruction: instruction)
        }
        else {
            var targetValue: CGFloat = 0
            var targetView: DinasView?
            if let target = target as? DinasView {
                
                let position = DinasPosition(item: target, type: DinasPositionType(rawValue: instruction.frameAttr.type.rawValue)!)
                
                targetView = target
                targetValue = DinasAnalyzeUtil.targetValue(with: position, relativeView: view)
            }
            else if let target = target as? DinasPosition {
                targetView = target.item
                targetValue = DinasAnalyzeUtil.targetValue(with: target, relativeView: view)
            }
            
            guard let target = targetView else {
                assert(false, "???")
                return 0
            }
            
            switch instruction.frameAttr.type {
            case .top, .left, .bottom, .right: do {
                return targetValue + instruction.offset
                }
            case .centerX: do {
                let muliplierOffset = (instruction.multiplier - 1) * target.bounds.width
                return muliplierOffset + instruction.offset + targetValue
                }
            case .centerY: do {
                let muliplierOffset = (instruction.multiplier - 1) * target.bounds.height
                return muliplierOffset + instruction.offset + targetValue
                }
            case .width, .height: do {
                return targetValue * instruction.multiplier + instruction.offset
                }
            default: do {
                }
            }
        }
        return 0
    }
    
    
    private static func targetValue(with position: DinasPosition, relativeView: DinasView) -> CGFloat {
        
        let relativeRect = DinasAnalyzeUtil.relativeRect(with: relativeView, targetView: position.item)
        
        var value: CGFloat = 0
        
        switch position.type {
        case .top:
            value = relativeRect.origin.y
        case .left:
            value = relativeRect.origin.x
        case .bottom:
            value = relativeRect.maxY
        case .right:
            value = relativeRect.maxX
        case .width:
            value = relativeRect.width
        case .height:
            value = relativeRect.height
        case .centerX:
            value = relativeRect.origin.x + relativeRect.width / 2
        case .centerY:
            value = relativeRect.origin.y + relativeRect.height / 2
        }
        
        return value
    }
    
    private static func relativeRect(with relativeView: DinasView, targetView: DinasView) -> CGRect {
        var relativeRect: CGRect
        if relativeView.superview == targetView {
            relativeRect = targetView.bounds
        }
        else {
            if let targetSuper = targetView.superview {
                relativeRect = targetSuper.convert(targetView.frame, to: relativeView.superview)
            }
            else {
                relativeRect = targetView.convert(targetView.frame, to: relativeView.superview)
            }
        }
        return relativeRect
    }

}
