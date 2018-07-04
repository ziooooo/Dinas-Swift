//
//  DinasTheardHelper.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/11.
//  Copyright © 2018年 jiazj. All rights reserved.
//

import Foundation

struct DinasThreadHelper {
    static func mainSync(_ block: @escaping ()->()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync { block() }
        }
    }
}
