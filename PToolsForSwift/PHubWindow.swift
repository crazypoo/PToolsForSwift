//
//  PHubWindow.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

class PHubWindow: UIWindow {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.windowLevel = UIWindowLevelAlert - 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
