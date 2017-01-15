//
//  CALayer+Extension.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/17/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

public extension CALayer {
    //MARK: - Methods
    
    /// Draw border in CALayer
    ///
    /// - Parameters:
    ///   - type: border type
    ///   - x: x-axis value of starting point
    ///   - y: y-axis value of staring point
    ///   - lineWidth: the width of border
    ///   - length: the length of border
    ///   - color: the corlor of border
    public func makeBorder(type: Border.type, x: CGFloat, y: CGFloat, lineWidth: CGFloat, length: CGFloat, color: UIColor){
        //Draw border with CGRect
        if type == .top || type == .bottom {
            self.frame = CGRect(x: x, y: y, width: length, height: lineWidth)
        }else{
            self.frame = CGRect(x: x, y: y, width: lineWidth, height: length)
        }
        self.backgroundColor = color.cgColor
    }
}
