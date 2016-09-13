//
//  PCarrie.swift
//  PToolsForSwift
//
//  Created by 邓杰豪 on 2016/9/13.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit
import CoreTelephony

class PCarrie: NSObject {
    
    class func currentRadioAccessTechnology()->String
    {
        let current = CTTelephonyNetworkInfo.init()
        return current.currentRadioAccessTechnology!
    }
    
    class func subscriberCellularProvider()->NSMutableDictionary
    {
        let dic = NSMutableDictionary.init()
        let current = CTTelephonyNetworkInfo.init()
        dic.setObject(current.subscriberCellularProvider!.carrierName, forKey: "carrierName" as NSCopying)
        dic.setObject(current.subscriberCellularProvider!.mobileCountryCode, forKey: "mobileCountryCode" as NSCopying)
        dic.setObject(current.subscriberCellularProvider!.mobileNetworkCode, forKey: "mobileNetworkCode" as NSCopying)
        dic.setObject(current.subscriberCellularProvider!.isoCountryCode, forKey: "isoCountryCode" as NSCopying)
        dic.setObject(NSNumber.init(booleanLiteral: current.subscriberCellularProvider!.allowsVOIP), forKey: "allowsVOIP" as NSCopying)
        return dic
    }
}
