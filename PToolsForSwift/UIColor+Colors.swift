//
//  UIColor+Colors.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

extension UIColor
{
    func colorWithHex(hexString:String)->UIColor
    {
        return UIColor.init(red: CGFloat(((Int(hexString)! & 0xFF0000) >> 16)/255), green: CGFloat(((Int(hexString)! & 0xFF00) >> 8)/255), blue: CGFloat((Int(hexString)! & 0xFF)/255), alpha: 1)
    }
    
    func RGBColor(r:CGFloat,g:CGFloat,b:CGFloat)->UIColor
    {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    func RGBAColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor
    {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    func randomColor()->UIColor
    {
        return UIColor.init(red: CGFloat(arc4random_uniform(256)/255), green: CGFloat(arc4random_uniform(256)/255), blue: CGFloat(arc4random_uniform(256)/255), alpha: 1)
    }
    
    func randomColorWithAlpha(alpha:CGFloat)->UIColor
    {
        return UIColor.init(red: CGFloat(arc4random_uniform(256)/255), green: CGFloat(arc4random_uniform(256)/255), blue: CGFloat(arc4random_uniform(256)/255), alpha: alpha)
    }
}
