//
//  DinasTarget.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

protocol DinasTargetProtocol {
}

extension Int: DinasTargetProtocol {
}

extension UInt: DinasTargetProtocol {
}

extension Float: DinasTargetProtocol {
}

extension Double: DinasTargetProtocol {
}

extension CGFloat: DinasTargetProtocol {
}

extension CGSize: DinasTargetProtocol {
}

extension CGPoint: DinasTargetProtocol {
}

extension DinasView: DinasTargetProtocol {
}

extension DinasPosition: DinasTargetProtocol {
}


struct DinasTarget {
    
    var target: AnyObject?
    
    init(target: AnyObject?) {
        self.target = target
    }
}
