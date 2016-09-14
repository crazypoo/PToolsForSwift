//
//  PNumberKeyBoard.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/14.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

protocol PNumberKeyBoardDelegate {
    func numberKeyboard(keyboard:PNumberKeyBoard,input number:String)
    func numberKeyboardBackspace(keyboard:PNumberKeyBoard)
}

class PNumberKeyBoard: UIView {

    let kLineWidth = 1
    let kNumFont = UIFont.systemFont(ofSize: 27)
    let delegate:PNumberKeyBoardDelegate?

    convenience init() {
        self.init()
        self.bounds = CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 216)

        for i in 0 ..< 4 {
            for j in 0 ..< 3 {
                let button = self.createButton(x: i, y: j)
                self.addSubview(button)
            }
        }

        let color = UIColor.init(red: 188/255, green: 192/255, blue: 199/255, alpha: 1)
        let line1 = UIView.init(frame: CGRect.init(x: Int((UIScreen.main.bounds.size.width - 2) / 3), y: 0, width: kLineWidth, height: 216))
        line1.backgroundColor = color
        self.addSubview(line1)
        let line2 = UIView.init(frame: CGRect.init(x: Int((UIScreen.main.bounds.size.width - 2) / 3 * 2), y: 0, width: kLineWidth, height: 216))
        line2.backgroundColor = color
        self.addSubview(line2)

        for i in 0..<3
        {
            let line = UIView.init(frame: CGRect.init(x: 0, y: 54 * (i + 1), width: Int(UIScreen.main.bounds.size.width), height: kLineWidth))
            line.backgroundColor = color
            self.addSubview(line)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createButton(x:NSInteger,y:NSInteger)->UIButton
    {
        let button:UIButton?
        var frameX:CGFloat = 0
        var frameW:CGFloat = 0
        switch y {
        case 0:
            frameX = 0
            frameW = (UIScreen.main.bounds.size.width - 2) / 3
            break
        case 1:
            frameX = (UIScreen.main.bounds.size.width - 2) / 3
            frameW = (UIScreen.main.bounds.size.width - 2) / 3
            break
        case 2:
            frameX = (UIScreen.main.bounds.size.width - 2) / 3 * 2
            frameW = (UIScreen.main.bounds.size.width - 2) / 3
            break
        default: break
        }

        let frameY:CGFloat = 54 * CGFloat(x)
        button = UIButton.init(frame: CGRect.init(x: frameX, y: frameY, width: frameW, height: 54))
        let num = y + 3 * x + 1
        button?.tag = num
        button?.addTarget(self, action: #selector(self.clickButton(sender:)), for: .touchUpInside)

        var colorNormal = UIColor.init(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
        var colorHightLighted = UIColor.init(red: 186/255, green: 189/255, blue: 194/255, alpha: 1)

        if num == 10 || num == 12
        {
            let colorTemp = colorNormal
            colorNormal = colorHightLighted
            colorHightLighted = colorTemp
        }
        button?.backgroundColor = colorNormal
        let imageSize = CGSize.init(width: frameW, height: 54)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        colorHightLighted.set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let pressedColorImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        button?.setImage(pressedColorImg, for: .highlighted)

        if num < 10
        {
            let labelNum = UILabel.init(frame: CGRect.init(x: 0, y: 15, width: frameW, height: 28))
            labelNum.text = String(num)
            labelNum.textColor = UIColor.black
            labelNum.textAlignment = .center
            labelNum.font = kNumFont
            button?.addSubview(labelNum)
        }
        else if num == 11
        {
            let labelNum = UILabel.init(frame: CGRect.init(x: 0, y: 15, width: frameW, height: 28))
            labelNum.text = "0"
            labelNum.textColor = UIColor.black
            labelNum.textAlignment = .center
            labelNum.font = kNumFont
            button?.addSubview(labelNum)
        }
        else if num == 10
        {
            let labelNum = UILabel.init(frame: CGRect.init(x: 0, y: 15, width: frameW, height: 28))
            labelNum.text = "."
            labelNum.textColor = UIColor.black
            labelNum.textAlignment = .center
            labelNum.font = kNumFont
            button?.addSubview(labelNum)
        }
        else
        {
            let labelNum = UILabel.init(frame: CGRect.init(x: 0, y: 15, width: frameW, height: 28))
            labelNum.text = "删除"
            labelNum.textColor = UIColor.black
            labelNum.textAlignment = .center
            labelNum.font = kNumFont
            button?.addSubview(labelNum)
        }

        return button!
    }

    func clickButton(sender:UIButton)
    {
        if sender.tag == 12
        {
            delegate?.numberKeyboardBackspace(keyboard: self)
        }
        else
        {
            var num = String(sender.tag)
            if sender.tag == 11
            {
                num = "0"
            }
            else if sender.tag == 10
            {
                num = "."
            }
            delegate?.numberKeyboard(keyboard: self, input: num)
        }
    }
}
