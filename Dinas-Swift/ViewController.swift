//
//  ViewController.swift
//  Dinas-Swift
//
//  Created by ziooooo on 2018/6/7.
//  Copyright © 2018年 ccc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let v = UIView()
        v.backgroundColor = UIColor.red
        view.addSubview(v)
        v.din.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(200)
        }
        
        let v2 = UIView()
        v2.backgroundColor = UIColor.blue
        v.addSubview(v2)
        v2.din.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalTo(v.din.right)
            make.height.equalToSuperview().offset(-100)
            make.width.equalTo(50)
        }
        
        let v3 = UIView()
        v3.backgroundColor = UIColor.yellow
        view.addSubview(v3)
        v3.din.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 50))
            make.top.equalTo(v2.din.bottom).offset(150)
            make.left.equalTo(v2.din.right)
        }
        
        let v4 = UIView()
        v4.backgroundColor = UIColor.green
        view.addSubview(v4)
        v4.din.makeConstraints { (make) in
            make.center.equalTo(v)
            make.size.equalTo(v3)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
