//
//  SwiftyBorderBackground.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/24/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Define Corners' CAShapeLayer and functions for them
public struct Corner{
    //Properties
    var topLeft = CAShapeLayer()
    var topRight = CAShapeLayer()
    var bottomLeft = CAShapeLayer()
    var bottomRight = CAShapeLayer()
    
    /// Corner type and starting angle of corners
    public enum type{
        case topLeft, topRight, bottomLeft, bottomRight
        var startAngle: CGFloat{
            switch self {
            case .topLeft:
                return CGFloat(M_PI)
            case .topRight:
                return CGFloat(-M_PI/2)
            case .bottomLeft:
                return CGFloat(M_PI/2)
            case .bottomRight:
                return CGFloat(0)
            }
        }
    }
    
    /// Get suitable CAShapeLayer
    ///
    /// - Parameter corner: corner type
    /// - Returns: suitable CAShapeLayer
    func get(_ corner: type) -> CAShapeLayer{
        switch corner {
        case .topLeft:
            return topLeft
        case .topRight:
            return topRight
        case .bottomRight:
            return bottomRight
        case .bottomLeft:
            return bottomLeft
        }
    }
}

/// Define borders' CALayer and functions of them
public struct Border{
    //Properties
    var bottom = CALayer()
    var right = CALayer()
    var top = CALayer()
    var left = CALayer()
    
    /// Border type
    public enum type{
        case top, bottom, left, right
    }
    
    /// Get suitable CALayer
    ///
    /// - Parameter border: border type
    /// - Returns: CALayer of suitable border
    func get(_ border: type) -> CALayer{
        switch border {
        case .top:
            return top
        case .bottom:
            return bottom
        case .left:
            return left
        case .right:
            return right
        }
    }
    
    /// Change color of all border
    ///
    /// - Parameter color: color to change
    func change(color: CGColor){
        top.backgroundColor = color
        bottom.backgroundColor = color
        left.backgroundColor = color
        right.backgroundColor = color
    }
}

/// The collection of corners, borders and background
struct DrawingLayer {
    var corner = Corner()
    var border = Border()
    var background = CAShapeLayer()
}
