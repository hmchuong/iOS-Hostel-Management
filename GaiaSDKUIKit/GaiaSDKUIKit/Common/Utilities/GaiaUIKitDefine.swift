//
//  RMLUIKitDefine.swift
//  GaiaSDKUIKit
//
//  Created by Hien Tran on 10/29/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

public let kBundleIDBase = "com.platewarrior.mobile"

public enum kStoryBoard: String {
    case Main         = "Main"
    case UIControls = "UIControls"
 
    public func inititalize()->UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    public func instantiateViewController(className: AnyClass)->UIViewController {
        
        let bundleId = Bundle(identifier: kBundleIDBase)
        let storyboard = UIStoryboard(name: self.rawValue, bundle: bundleId)
        print(String.className(aClass: className))
        return storyboard.instantiateViewController(withIdentifier: String.className(aClass: className))
    }
    
    public func instantiateViewController<T:UIViewController>()->T {
        
        let bundleId = Bundle(identifier: kBundleIDBase)
        let storyboard = UIStoryboard(name: self.rawValue, bundle: bundleId)
        let name = String.className(aClass: T.classForCoder())
        print("Controller name:  \(name)")
        return storyboard.instantiateViewController(withIdentifier: name) as! T
    }
}
