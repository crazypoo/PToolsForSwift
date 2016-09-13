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
        hubWindow().rootViewController?.perform(#selector(PHubViewController.hide(completion:)), with: {
          hubWindow().isHidden = true
//            setHubWindow(hubWindow: nil)
            UIApplication.shared.keyWindow?.makeKey()
        })
    }
    
    class func setColors(colors:NSArray)
    {
        let isLegal = true
        if let object as AnyObject in colors
        {
            if object {
                <#code#>
            }
        }
        
    }
    
    class func resetDefultSetting()
    {
        
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
        if objc_getAssociatedObject(self, #function) == nil
        {
            setHubBackgroundColor(hubBackgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.65))
        }
        return objc_getAssociatedObject(self, #function) as! UIColor
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
