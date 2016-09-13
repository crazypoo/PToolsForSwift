//
//  PHubView.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit
import Foundation

enum CircleLengthStatus : Int {
    case Decrease
    case Increase
    case Waiting
}

extension UIColor
{
    func r() -> CGFloat {
        return self.rgba().object(forKey: "r") as! CGFloat
    }
    
    func g() -> CGFloat {
        return self.rgba().object(forKey: "g") as! CGFloat
    }
    
    func b() -> CGFloat {
        return self.rgba().object(forKey: "b") as! CGFloat
    }
    
    func a() -> CGFloat {
        return self.rgba().object(forKey: "a") as! CGFloat
    }
    
    func mixColor(otherColor:UIColor)->UIColor
    {
        let newAlpha = 1 - (1 - self.a()) * (1 - otherColor.a())
        let newRed = self.r() * self.a() / newAlpha + otherColor.r() * otherColor.a() * (1 - self.a()) / newAlpha
        let newGreen = self.g() * self.a() / newAlpha + otherColor.g() * otherColor.a() * (1 - self.a()) / newAlpha
        let newBlue = self.b() * self.a() / newAlpha + otherColor.b() * otherColor.a() * (1 - self.a()) / newAlpha
        return UIColor.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }

    func rgba()->NSDictionary
    {
        let rgba = objc_getAssociatedObject(self, #function)
        if rgba == nil
        {
            var red:CGFloat = 0
            var green:CGFloat = 0
            var blue:CGFloat = 0
            var alpha:CGFloat = 0
            
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            setRGBA(rgba: ["r":red,"g":green,"b":blue,"a":alpha])
        }
        
        return objc_getAssociatedObject(self, #function) as! NSDictionary
    }
    

    func setRGBA(rgba:NSDictionary)
    {
        objc_setAssociatedObject(self, self.bridgeRetained(obj: self.rgba()), rgba, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func bridge<T : AnyObject>(obj : T) -> UnsafeRawPointer {
        return UnsafeRawPointer(Unmanaged.passUnretained(obj).toOpaque())
    }
    
    func bridge<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
        return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue()
    }
    
    func bridgeRetained<T : AnyObject>(obj : T) -> UnsafeRawPointer {
        return UnsafeRawPointer(Unmanaged.passRetained(obj).toOpaque())
    }
    
    func bridgeTransfer<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
        return Unmanaged<T>.fromOpaque(ptr).takeRetainedValue()
    }
}

class PHubView: UIView {
    var hudColors:NSArray?
    var hubLineWidth:CGFloat?
    var length:NSInteger = 0
    var rotateAngle:NSInteger = 0
    var status:CircleLengthStatus?
    var colorIndex:NSInteger?
    var finalColor:UIColor?
    var prevColor:UIColor?
    var gradualColor:UIColor?
    var waitingFrameCount:NSInteger?
    var circleCenter:CGPoint?
    var circleRadius:CGFloat?
    
    func refreshCircle()
    {
        DispatchQueue.global(qos: .background).async {
            if self.status == .Decrease
            {
                self.length -= 8
                self.rotateAngle += 4
                
                if self.length <= 2
                {
                    self.length = 2
                    self.status = .Waiting
                    self.colorIndex = self.colorIndex! + 1
                    self.colorIndex = self.colorIndex! % (self.hudColors?.count)!
                    self.prevColor = self.finalColor
                    self.finalColor = self.hudColors?.object(at: self.colorIndex!) as! UIColor?
                }
            }
            else if self.status == .Increase
            {
                self.length += 8
                let deltaLength = sin(8/360*M_PI_2)*360
                self.rotateAngle += NSInteger(4 + deltaLength)
                
                if self.length >= 200
                {
                    self.length = 200
                    self.status = .Waiting
                }
            }
            else if self.status == .Waiting
            {
                self.waitingFrameCount = self.waitingFrameCount! + 1
                self.rotateAngle += 4
                
                if self.length == 2
                {
                    let colorAPercent = CGFloat(self.waitingFrameCount! / 30)
                    let colorBPercent = 1 - colorAPercent
                    let transparentColorA = UIColor.init(red: (self.finalColor?.r())!, green: (self.finalColor?.g())!, blue: (self.finalColor?.b())!, alpha: colorAPercent)
                    let transparentColorB = UIColor.init(red: (self.prevColor?.r())!, green: (self.prevColor?.g())!, blue: (self.prevColor?.b())!, alpha: colorBPercent)
                    self.gradualColor = transparentColorA.mixColor(otherColor: transparentColorB)
                }
                
                if self.waitingFrameCount == 30
                {
                    self.waitingFrameCount = 0
                    if self.length == 2
                    {
                        self.status = .Increase
                    }
                    else
                    {
                        self.status = .Decrease
                    }
                }
            }
            self.rotateAngle = self.rotateAngle % 360
            DispatchQueue.main.async {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * Double(self.rotateAngle) / 180.0))
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(self.hubLineWidth!)
        
        if self.status == .Waiting && self.length == 2
        {
            context?.setStrokeColor(red: (self.gradualColor?.r())!, green: (self.gradualColor?.g())!, blue: (self.gradualColor?.b())!, alpha: (self.gradualColor?.a())!)
        }
        else
        {
            context?.setStrokeColor(red: (self.finalColor?.r())!, green: (self.finalColor?.g())!, blue: (self.finalColor?.b())!, alpha: (self.finalColor?.a())!)
        }
        
        let deltaLength = sin(Double(self.length) / 360) * M_PI_2 * 360
        let startAngle = CGFloat(M_PI * Double(-deltaLength) / 180.0)
        context?.addArc(center: self.circleCenter!, radius: self.circleRadius!, startAngle: startAngle, endAngle: 0, clockwise: false)
        
        context?.strokePath()
        
        self.perform(#selector(self.refreshCircle), with: nil, afterDelay: 1 / 60)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.rotateAngle = NSInteger(arc4random() % 360)
        self.length = 200
        self.status = .Decrease
        self.waitingFrameCount = 0
        self.circleCenter = CGPoint.init(x: frame.size.width / 2, y: frame.size.height / 2)
        self.circleRadius = frame.size.width / 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil
        {
            self.colorIndex = NSInteger(Int(arc4random()) % (self.hudColors?.count)!)
            self.finalColor = self.hudColors?.object(at: self.colorIndex!) as! UIColor?
        }
        else
        {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.refreshCircle), object: nil)
        }
    }
}

