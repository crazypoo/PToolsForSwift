//
//  PHubViewCOntroller.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView
{
    func centerInBounds(bounds:CGRect)
    {
        var newFrame = self.frame
        newFrame.origin.x = bounds.size.width / 2 - newFrame.size.width / 2
        newFrame.origin.y = bounds.size.height / 2 - newFrame.size.height / 2
        self.frame = newFrame
    }
}

class PHubViewController: UIViewController {
    var hubColors:NSArray?
    var hubBackgroundColor:UIColor?
    var hubLineWidth:CGFloat?
    var centerView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultHUB()
        
        self.centerView?.transform =  CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        weak var weakSelf = PHubViewController()
        UIView.animate(withDuration: 0.3, animations: { 
            weakSelf?.centerView?.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }) { (finish:Bool) in
            UIView.animate(withDuration: 0.3, animations: { 
                weakSelf?.centerView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                }, completion: { (finish:Bool) in
                    UIView.animate(withDuration: 0.3/2, animations: { 
                        weakSelf?.centerView?.transform = CGAffineTransform.identity
                    })
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hide(completion: @escaping (Void) -> Void) {
        weak var wealSelf = self
        UIView.animate(withDuration: 1, animations: {
            wealSelf?.centerView?.alpha = 0
            },completion: {(finished: Bool) in
                completion()
        })
    }
    
    func setupDefaultHUB()
    {
        self.centerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        self.centerView?.centerInBounds(bounds:UIScreen.main.bounds)
        self.centerView?.backgroundColor = self.hubBackgroundColor
        self.centerView?.layer.cornerRadius = 10
        self.centerView?.layer.masksToBounds = true
        
        let inboxView = PHubView.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 90))
        inboxView.hudColors = self.hubColors
        inboxView.hubLineWidth = self.hubLineWidth
        inboxView.centerInBounds(bounds: (self.centerView?.bounds)!)
        self.centerView?.addSubview(inboxView)
        
        self.view.addSubview(self.centerView!)
    }
}
