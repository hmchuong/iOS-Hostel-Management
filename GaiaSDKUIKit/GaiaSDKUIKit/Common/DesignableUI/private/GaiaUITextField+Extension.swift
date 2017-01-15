//
//  GaiaUITextFieldExtension.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 12/28/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - Rectangle for text Methods
extension GaiaUITextField {
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        // Return the bounds with customize left and right padding
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: leftPaddingT, bottom: 0, right: rightPaddingT))
    }
}

// MARK: - Lifecycle
extension GaiaUITextField {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public var intrinsicContentSize : CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric)
    }
    
    
}

// MARK: - Set background
extension GaiaUITextField{
    
    /// Set up background for the text field
    ///
    /// - Parameter width: the border width of text field
    func setBackgroundTextField(_ width: CGFloat){
        //Draw background with several parameters
        drawingLayer.background.makeBackground(topLeft: topleftCorner,
                                               topRight: toprightCrn,
                                               bottomLeft: bottomleftCrn,
                                               bottomRight: btmrightCrn,
                                               y_start: y_start,
                                               y_end: y_end,
                                               width: self.frame.width,
                                               cornerRadius: cornerRadius,
                                               borderWidth: borderWidth,
                                               fillColor: bgColor,
                                               transparent: bgTransparent)
        
        //Insert background to the back of all sublayers
        layer.insertSublayer(drawingLayer.background, at: 0)
        
    }
}

// MARK: - Show/hide corners
extension GaiaUITextField{
    
    /// Calculate the center point of the corner
    ///
    /// - Parameter corner: the corner type you want to calculate center point
    /// - Returns: center point of the corner
    private func calcCenterPoint(for corner: Corner.type)-> CGPoint{
        var center_x = CGFloat(0)
        var center_y = CGFloat(0)
        
        //Calculate y-point
        if corner == .topRight || corner == .topLeft{
            center_y = cornerRadius + borderWidth/2 + y_start
        }else{
            center_y = y_end - cornerRadius - borderWidth/2
        }
        
        //Calculate x-point
        if corner == .bottomRight || corner == .topRight{
            center_x = frame.width - cornerRadius - borderWidth/2
        }else{
            center_x = cornerRadius + borderWidth/2
        }
        
        return CGPoint(x: center_x, y: center_y)
    }
    
    /// Draw corner and add to the layer
    ///
    /// - Parameter corner: the corner type you want to add to layer
    private func add(corner: Corner.type){
        //Get suitable corner layer
        let cornerLayer = drawingLayer.corner.get(corner)
        
        //Draw corner
        cornerLayer.makeCorner(center: calcCenterPoint(for: corner),
                               startAngle: corner.startAngle,
                               radius: cornerRadius,
                               color: borderColorUI,
                               lineWidth: borderWidth)
        
        //Add corner to layer
        layer.addSublayer(cornerLayer)
    }
    
    
    /// Draw 4 corners respectively.
    ///
    /// Add corner to or remove corner from layer
    func setupCorner() {
        
        //Show/hide top left corner
        if topleftCorner {
            add(corner: .topLeft)
        } else {
            drawingLayer.corner.topLeft.removeFromSuperlayer()
        }
        
        //Show/hide top right corner
        if toprightCrn {
            add(corner: .topRight)
        } else {
            drawingLayer.corner.topRight.removeFromSuperlayer()
        }
        
        //Show/hide bottom left corner
        if bottomleftCrn {
            add(corner: .bottomLeft)
        } else {
            drawingLayer.corner.bottomLeft.removeFromSuperlayer()
        }
        
        //Show/hide bottom right corner
        if btmrightCrn {
            add(corner: .bottomRight)
        } else {
            drawingLayer.corner.bottomRight.removeFromSuperlayer()
        }
    }
}

//MARK: - Show/hide borders
extension GaiaUITextField {
    
    /// Calculate x-axis value of border
    ///
    /// - Parameters:
    ///   - type: border type you want to calculate
    ///   - width: border width
    /// - Returns: x-axis value of the border
    private func calcX(for type: Border.type, width: CGFloat)-> CGFloat{
        switch type {
        case .top:
            if topleftCorner{
                return cornerRadius + width/2
            }else{
                return CGFloat(0)
            }
        case .bottom:
            if bottomleftCrn{
                return cornerRadius + width/2
            }else{
                return CGFloat(0)
            }
        case .left:
            return CGFloat(0)
        case .right:
            return frame.width - width
        }
    }
    
    /// Calculate y-axis value of border
    ///
    /// - Parameters:
    ///   - type: border type you want to calculate
    ///   - width: border width
    /// - Returns: y-axis value of the border
    private func calcY(for type: Border.type, width: CGFloat)->CGFloat{
        switch type {
        case .top:
            return y_start
        case .bottom:
            return y_end - width
        case .left:
            if topleftCorner{
                return y_start + cornerRadius + width/2
            }else{
                return y_start
            }
        case .right:
            if toprightCrn{
                return y_start + cornerRadius + width/2
            }else{
                return y_start
            }
        }
    }
    
    /// Calculate the length of border
    ///
    /// - Parameters:
    ///   - type: border type you want to calculate
    ///   - width: border width
    /// - Returns: length of the border
    private func calcLength(for type: Border.type,width: CGFloat)-> CGFloat{
        switch type {
        case .top:
            var length = frame.width
            if topleftCorner {
                length -= (cornerRadius + width/2)
            }
            if toprightCrn {
                length -= (cornerRadius + width/2)
            }
            return length
        case .bottom:
            var length = frame.width
            if bottomleftCrn {
                length -= (cornerRadius + width/2)
            }
            if btmrightCrn {
                length -= (cornerRadius + width/2)
            }
            return length
        case .left:
            var length = y_end - y_start
            if topleftCorner{
                length -= (cornerRadius + width/2)
            }
            if bottomleftCrn{
                length -= (cornerRadius + width/2)
            }
            return length
        case .right:
            var length = y_end - y_start
            if toprightCrn{
                length -= (cornerRadius + width/2)
            }
            if btmrightCrn{
                length -= (cornerRadius + width/2)
            }
            return length
        }
    }
    
    /// Draw and add border to layer
    ///
    /// - Parameters:
    ///   - border: border type you want to add
    ///   - width: border width
    func add(border: Border.type, width: CGFloat){
        // Get suitable border layer
        let borderLayer = drawingLayer.border.get(border)
        
        //Draw border
        borderLayer.makeBorder(type: border,
                               x: calcX(for: border, width: width),
                               y: calcY(for: border, width: width),
                               lineWidth: width,
                               length: calcLength(for: border, width: width),
                               color: borderColorUI)
        
        //Add border to sublayers
        layer.addSublayer(borderLayer)
    }
    
    /// Draw 4 borders respectively
    ///
    /// Add border to or remove border from layer
    func setupBorder() {
        
        //Show/hide top border
        if topBorder {
            add(border: .top, width: borderWidth)
        } else {
            drawingLayer.border.top.removeFromSuperlayer()
        }
        
        //Show/hide bottom border
        if bottomBorder {
            add(border: .bottom, width: borderWidth)
        } else {
            drawingLayer.border.bottom.removeFromSuperlayer()
        }
        
        //Show/hide left border
        if leftBorder {
            add(border: .left, width: borderWidth)
        } else {
            drawingLayer.border.left.removeFromSuperlayer()
        }
        
        //Show/hide right border
        if rightBorder {
            add(border: .right, width: borderWidth)
        } else {
            drawingLayer.border.right.removeFromSuperlayer()
        }
        
        self.setNeedsDisplay()
    }
}

