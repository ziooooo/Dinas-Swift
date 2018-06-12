//
//  DinasViewDSL.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

public struct DinasViewDSL {

    public func makeConstraints(_ closure: (_ make: DinasMaker) -> Void) {
        DinasMaker.makeStructures(item: self.view, closure: closure).bulid()
    }
    
    public func makeConstraintsDelay(_ closure: (_ make: DinasMaker) -> Void) -> DinasMaker {
        return DinasMaker.makeStructures(item: self.view, closure: closure)
    }
    
    let view: DinasView
    
    init(view: DinasView) {
        assert((view.superview != nil), "没superView 怎么玩啊")
        self.view = view
    }
    
}

extension DinasViewDSL {
    var top: DinasPosition {
        return DinasPosition(item: view, type: .top)
    }
    
    var left: DinasPosition {
        return DinasPosition(item: view, type: .left)
    }
    
    var bottom: DinasPosition {
        return DinasPosition(item: view, type: .bottom)
    }
    
    var right: DinasPosition {
        return DinasPosition(item: view, type: .right)
    }
    
    var width: DinasPosition {
        return DinasPosition(item: view, type: .width)
    }
    
    var height: DinasPosition {
        return DinasPosition(item: view, type: .height)
    }
    
    var centerX: DinasPosition {
        return DinasPosition(item: view, type: .centerX)
    }
    
    var centerY: DinasPosition {
        return DinasPosition(item: view, type: .centerY)
    }
}
