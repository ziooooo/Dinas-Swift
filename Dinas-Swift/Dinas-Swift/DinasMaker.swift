//
//  DinasMaker.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

public class DinasMaker {
    
    private(set) var item: DinasView
    
    private(set) var structure: DinasStructure
    
    lazy private var bulidQueue = DispatchQueue(label: "dinas-queue")
    
    
    init(item: DinasView) {
        self.item = item
        structure = DinasStructure(item: item)
    }
    
    @discardableResult
    static func makeStructures(item: DinasView, closure: (_ make: DinasMaker) -> Void) -> DinasMaker {
        let maker = DinasMaker(item: item)
        closure(maker)
        return maker
    }
    
    @discardableResult
    func bulid() -> CGRect {
        let originalFrame = item.frame
        let frame = frameGenerate(originalFrame: originalFrame)
        
        item.frame = frame
        
        return frame
    }
    
    func bulidAsync(semaphore: DispatchSemaphore? = nil, _ completion: ((CGRect) -> ())? = nil) {
        
        var frame = CGRect.zero
        var originalFrame = CGRect.zero
        
        
        DinasThreadHelper.mainSync {
            originalFrame = self.item.frame
        }
        
        bulidQueue.async {
            if let sem = semaphore {
                sem.wait()
            }
            frame = self.frameGenerate(originalFrame: originalFrame)
            DispatchQueue.main.sync {
                self.item.frame = frame
                if let sem = semaphore {
                    sem.signal()
                }
                if let completion = completion {
                    completion(frame)
                }
            }
        }
    }
    
    
    /// 生成frame
    ///
    /// - Parameter originalFrame: 原始frame
    /// - Returns:
    func frameGenerate(originalFrame: CGRect) -> CGRect {
        var analyzeRes = DinasAnalyzeUtil.analyze(attributes: structure.attributes)
        
        
        var x = originalFrame.origin.x
        var y = originalFrame.origin.y
        var w = originalFrame.width
        var h = originalFrame.height
        
        DinasThreadHelper.mainSync {
            if self.item is UILabel {
                let label = self.item as! UILabel
                if let insWidth = analyzeRes[DIN_W_ANALYZE_KEY]?[DIN_WIDTH_KEY] {
                    if let valueTarget = insWidth.equalToAttr?.target as? DinasConstantTarget {
                        if valueTarget.dinasConstantTargetValueFor(instruction: insWidth) == 0 {
                            
                            if let labelText = label.text {
                                let text = NSString(string: labelText)
                                let attributes = [NSAttributedStringKey.font: label.font!]
                                let option = NSStringDrawingOptions.usesLineFragmentOrigin
                                let textW = text.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil).width
                                
                                insWidth.equalToAttr = DinasEqualToAttribute(target: textW)
                                
                                analyzeRes[DIN_X_ANALYZE_KEY]![DIN_WIDTH_KEY] = insWidth
                                analyzeRes[DIN_W_ANALYZE_KEY]![DIN_WIDTH_KEY] = insWidth
                            }
                        }
                    }
                }
            }
        }
        
        
        
        //x
        let insXDic = analyzeRes[DIN_X_ANALYZE_KEY]
        if let insXDic = insXDic {
            let insLeft = insXDic[DIN_LEFT_KEY]
            let insCenterX = insXDic[DIN_CENTERX_KEY]
            let insWidth = insXDic[DIN_WIDTH_KEY]
            let insRight = insXDic[DIN_RIGHT_KEY]
            
            if let insLeft = insLeft {
                x = DinasAnalyzeUtil.execute(instruction: insLeft, to: item)
            }
            else if let insRight = insRight,
                let insWidth = insWidth {
                let right = DinasAnalyzeUtil.execute(instruction: insRight, to: item)
                let width = DinasAnalyzeUtil.execute(instruction: insWidth, to: item)
                
                x = right - width
            }
            else if let insCenterX = insCenterX,
                let insWidth = insWidth {
                let centerX = DinasAnalyzeUtil.execute(instruction: insCenterX, to: item)
                let width = DinasAnalyzeUtil.execute(instruction: insWidth, to: item)
                x = centerX - width / 2
            }
            else if let insCenterX = insCenterX,
                let insRight = insRight {
                let centerX = DinasAnalyzeUtil.execute(instruction: insCenterX, to: item)
                let right = DinasAnalyzeUtil.execute(instruction: insRight, to: item)
                x = centerX - (right - centerX)
            }
        }
        
        //y
        let insYDic = analyzeRes[DIN_Y_ANALYZE_KEY]
        if let insYDic = insYDic {
            
            let insTop = insYDic[DIN_TOP_KEY]
            let insBottom = insYDic[DIN_BOTTOM_KEY]
            let insHeight = insYDic[DIN_HEIGHT_KEY]
            let insCenterY = insYDic[DIN_CENTERY_KEY]
            
            if let insTop = insTop {
                y = DinasAnalyzeUtil.execute(instruction: insTop, to: item)
            }
            else if let insBottom = insBottom,
                let insHeight = insHeight {
                let bottom = DinasAnalyzeUtil.execute(instruction: insBottom, to: item)
                let height = DinasAnalyzeUtil.execute(instruction: insHeight, to: item)
                
                y = bottom - height
            }
            else if let insCenterY = insCenterY,
                let insHeight = insHeight {
                let centerY = DinasAnalyzeUtil.execute(instruction: insCenterY, to: item)
                let height = DinasAnalyzeUtil.execute(instruction: insHeight, to: item)
                y = centerY - height / 2
            }
            else if let insCenterY = insCenterY,
                let insBottom = insBottom {
                let centerY = DinasAnalyzeUtil.execute(instruction: insCenterY, to: item)
                let bottom = DinasAnalyzeUtil.execute(instruction: insBottom, to: item)
                y = centerY - (bottom - centerY)
            }
        }
        
        //w
        let insWDic = analyzeRes[DIN_W_ANALYZE_KEY]
        if let insWDic = insWDic {
            
            let insWidth = insWDic[DIN_WIDTH_KEY]
            let insLeft = insWDic[DIN_LEFT_KEY]
            let insRight = insWDic[DIN_RIGHT_KEY]
            let insCenterX = insWDic[DIN_CENTERX_KEY]
            
            if let insWidth = insWidth {
                w = DinasAnalyzeUtil.execute(instruction: insWidth, to: item)
            }
            else if let insLeft = insLeft,
                let insRight = insRight {
                let left = DinasAnalyzeUtil.execute(instruction: insLeft, to: item)
                let right = DinasAnalyzeUtil.execute(instruction: insRight, to: item)
                
                w = right - left
            }
            else if let insLeft = insLeft,
                let insCenterX = insCenterX {
                let left = DinasAnalyzeUtil.execute(instruction: insLeft, to: item)
                let centerX = DinasAnalyzeUtil.execute(instruction: insCenterX, to: item)
                w = (centerX - left) * 2
            }
            else if let insRight = insRight,
                let insCenterX = insCenterX {
                let right = DinasAnalyzeUtil.execute(instruction: insRight, to: item)
                let centerX = DinasAnalyzeUtil.execute(instruction: insCenterX, to: item)
                w = (right - centerX) * 2
            }
        }
        
        //h
        let insHDic = analyzeRes[DIN_H_ANALYZE_KEY]
        if let insHDic = insHDic {
            
            let insHeight = insHDic[DIN_HEIGHT_KEY]
            let insTop = insHDic[DIN_TOP_KEY]
            let insBottom = insHDic[DIN_BOTTOM_KEY]
            let insCenterY = insHDic[DIN_CENTERY_KEY]
            
            if let insHeight = insHeight {
                h = DinasAnalyzeUtil.execute(instruction: insHeight, to: item)
            }
            else if let insTop = insTop,
                let insBottom = insBottom {
                let top = DinasAnalyzeUtil.execute(instruction: insTop, to: item)
                let bottom = DinasAnalyzeUtil.execute(instruction: insBottom, to: item)
                
                h = bottom - top
            }
            else if let insTop = insTop,
                let insCenterY = insCenterY {
                let top = DinasAnalyzeUtil.execute(instruction: insTop, to: item)
                let centerY = DinasAnalyzeUtil.execute(instruction: insCenterY, to: item)
                h = (centerY - top) * 2
            }
            else if let insBottom = insBottom,
                let insCenterY = insCenterY {
                let bottom = DinasAnalyzeUtil.execute(instruction: insBottom, to: item)
                let centerY = DinasAnalyzeUtil.execute(instruction: insCenterY, to: item)
                h = (bottom - centerY) * 2
            }
        }
        
        if item is UILabel {//去黑线
            w = ceil(w)
        }
        
        let finalRect = CGRect(x: x, y: y, width: w, height: h)
        return finalRect
    }
    
    
}

extension DinasMaker {
    
    var top: DinasStructure {
        return structure.top
    }
    
    var left: DinasStructure {
        return structure.left
    }
    
    var bottom: DinasStructure {
        return structure.bottom
    }
    
    var right: DinasStructure {
        return structure.right
    }
    
    var width: DinasStructure {
        return structure.width
    }
    
    var height: DinasStructure {
        return structure.height
    }
    
    var centerX: DinasStructure {
        return structure.centerX
    }
    
    var centerY: DinasStructure {
        return structure.centerY
    }
    
    var size: DinasStructure {
        return structure.width.height
    }
    
    var center: DinasStructure {
        return structure.centerX.centerY
    }
    
    var edges: DinasStructure {
        return structure.top.left.bottom.right
    }
    
    
}
