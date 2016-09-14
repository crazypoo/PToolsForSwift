//
//  PHub.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit
import Foundation

class PHub: NSObject {
    class func show()
    {
        let inboxViewController = PHubViewController()
        inboxViewController.hubColors = hubColors()
        inboxViewController.hubBackgroundColor = hubBackgroundColor()
        inboxViewController.hubLineWidth = hubLineWidth()
        hubWindow().rootViewController = inboxViewController
        hubWindow().makeKeyAndVisible()
    }
    
    class func hide()
    {
//        hubWindow().rootViewController?.performSelector(inBackground: #selector(PHubViewController.hide(completion:)), with: {
//            hubWindow().isHidden = true
//            let a = PHubWindow()
//            setHubWindow(hubWindow: a)
//            UIApplication.shared.keyWindow?.makeKey()
//        })
    }
    
    class func setColors(colors:NSArray)
    {
        var isLegal = true
        for objects: Any in colors {
            if (objects as AnyObject).isKind(of: UIColor.superclass()!)
            {
                isLegal = false
                break
            }

            if colors.count > 1 && isLegal == true
            {
                setHubColors(hubColors: colors)
            }
            else
            {
                NSLog("填入的顏色不被採用, 建議要填入兩個以上的顏色, 或是元素不合法.")
            }
        }
    }
    
    class func resetDefultSetting()
    {
        PHub.setColors(colors: [UIColor.red, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.white])
        PHub.setHubBackgroundColor(hubBackgroundColor: UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.75))
        PHub.setHubLineWidth(hudLineWidth: 2)
    }
    
    class func setHubWindow(hubWindow:PHubWindow)
    {
        objc_setAssociatedObject(self, PHub.bridgeRetained(obj: PHub.hubWindow()), hubWindow, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hubWindow()->PHubWindow
    {
        if objc_getAssociatedObject(self, #function) == nil
        {
            setHubWindow(hubWindow: PHubWindow.init(frame: UIScreen.main.bounds))
        }
        return objc_getAssociatedObject(self, #function) as! PHubWindow
    }
    
    class func setHubColors(hubColors:NSArray)
    {
        objc_setAssociatedObject(self, PHub.bridgeRetained(obj: PHub.hubColors()), hubColors, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hubColors()->NSArray
    {
        if objc_getAssociatedObject(self, #function) == nil
        {
            setHubColors(hubColors: [UIColor.clear,UIColor.green,UIColor.yellow,UIColor.blue])
        }
        return objc_getAssociatedObject(self, #function) as! NSArray
    }
    
    class func setHubBackgroundColor(hubBackgroundColor:UIColor)
    {
        objc_setAssociatedObject(self, PHub.bridgeRetained(obj: PHub.hubBackgroundColor()), hubBackgroundColor, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hubBackgroundColor()->UIColor
    {
        if objc_getAssociatedObject(self, NSStringFromSelector(#function)) == nil
        {
            setHubBackgroundColor(hubBackgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.65))
        }
        return objc_getAssociatedObject(self, NSStringFromSelector(#function)) as! UIColor
    }
    
    class func setHubLineWidth(hudLineWidth:CGFloat)
    {
        objc_setAssociatedObject(self, PHub.bridgeRetained(obj: PHub.hubLineWidth() as AnyObject), hudLineWidth, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    class func hubLineWidth()->CGFloat
    {
        if objc_getAssociatedObject(self, #function) == nil
        {
            setHubLineWidth(hudLineWidth: 2)
        }
        let hubLineWidth = objc_getAssociatedObject(self, #function)
        return hubLineWidth as! CGFloat
    }
    
    func bridge<T : AnyObject>(obj : T) -> UnsafeRawPointer {
        return UnsafeRawPointer(Unmanaged.passUnretained(obj).toOpaque())
    }
    
    func bridge<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
        return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue()
    }
    
    class func bridgeRetained<T : AnyObject>(obj : T) -> UnsafeRawPointer {
        return UnsafeRawPointer(Unmanaged.passRetained(obj).toOpaque())
    }
    
    func bridgeTransfer<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
        return Unmanaged<T>.fromOpaque(ptr).takeRetainedValue()
    }
}
