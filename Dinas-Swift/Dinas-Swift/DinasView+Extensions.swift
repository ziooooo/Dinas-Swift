//
//  DinasView+Extension.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 robam. All rights reserved.
//

import UIKit

public extension DinasView {
    
    public var din: DinasViewDSL {
        return DinasViewDSL(view: self)
    }
}
