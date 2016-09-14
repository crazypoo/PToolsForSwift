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
    func colorWithHex(hexString:NSString)->UIColor
    {
        var Str = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#")
        {
            Str = ((hexString as NSString).substring(from: 1) as NSString) as String
        }
        let Red = (Str as NSString ).substring(to: 2)
        let Green = ((Str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let Blue = ((Str as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string:Red).scanHexInt32(&r)
        Scanner(string: Green).scanHexInt32(&g)
        Scanner(string: Blue).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
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
        return UIColor.init(red: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), alpha: 1)
    }
    
    func randomColorWithAlpha(alpha:CGFloat)->UIColor
    {
        return UIColor.init(red: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), alpha: alpha)
    }
}
