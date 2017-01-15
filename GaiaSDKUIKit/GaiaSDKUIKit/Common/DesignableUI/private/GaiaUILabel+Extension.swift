//
//  GaiaUILabelExtension.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - Lifecycle
extension GaiaUILabel{
    override public func drawText(in rect: CGRect)
    {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize
    {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
    override public func draw(_ rect: CGRect) {
        //Draw border, corner and background, rotate label
        super.draw(rect)
        self.setupBorder()
        self.setupCorner()
        self.setBackground(borderWidth)
        self.rotate()
        
    }
    
}

// MARK: - Rotate label
extension GaiaUILabel{
    
    /// Rotate label
    func rotate(){
        // Calculate rotation angle
        let rotationAngle = Double(rotation/180) * M_PI
        // Rotate label
        self.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        self.layer.allowsEdgeAntialiasing = true
    }
}

// MARK: - For HTML presentation
extension GaiaUILabel{
    
    /// Present HTML format
    func html(){
        // Set multiple lines
        self.numberOfLines = 0
        
        // Get URL from HTML source
        urls = extractUrl(from: text!)
        
        // Transform HTML to attributedText
        let htmlText = text!
        if let htmlData = htmlText.data(using: String.Encoding.unicode) {
            do {
                
                self.attributedText = try NSMutableAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                
            } catch let e as NSError {
                print("Couldn't translate \(htmlText): \(e.localizedDescription) ")
            }
        }
        
        
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapHandle))
        self.addGestureRecognizer(tapGesture)
    }
    
    /// Handle with tap in UILabel
    ///
    /// - Parameter sender: sender
    func tapHandle(sender: UITapGestureRecognizer){
        let text = (self.text)!
        
        for (key, value) in self.urls {
            let range = (text as NSString).range(of: key)
            if sender.didTapAttributedTextInLabel(label: self, inRange: range){
                UIApplication.shared.openURL(URL(string: value)!)
            }
        }
    }
}

// MARK: - Set background
extension GaiaUILabel{
    /// Set background of Label
    ///
    /// - Parameter width: the border width of label
    func setBackground(_ width: CGFloat){
        //Draw background with several parameters
        drawingLayer.background.makeBackground(topLeft: topleftCorner,
                                               topRight: toprightCrn,
                                               bottomLeft: bottomleftCrn,
                                               bottomRight: btmrightCrn,
                                               y_start: 0,
                                               y_end: self.frame.height,
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
extension GaiaUILabel{
    /// Calculate the center point of the corner
    ///
    /// - Parameter corner: the corner type you want to calculate center point
    /// - Returns: center point of the corner
    private func calcCenterPoint(for corner: Corner.type)-> CGPoint{
        var center_x = CGFloat(0)
        var center_y = CGFloat(0)
        
        //Calculate y-point
        if corner == .topRight || corner == .topLeft{
            center_y = cornerRadius + borderWidth/2 + 0
        }else{
            center_y = frame.height - cornerRadius - borderWidth/2
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

// MARK: - Show/hide borders
extension GaiaUILabel{
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
            return 0
        case .bottom:
            return frame.height - width
        case .left:
            if topleftCorner{
                return cornerRadius + width/2
            }else{
                return 0
            }
        case .right:
            if toprightCrn{
                return cornerRadius + width/2
            }else{
                return 0
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
            var length = frame.height
            if topleftCorner{
                length -= (cornerRadius + width/2)
            }
            if bottomleftCrn{
                length -= (cornerRadius + width/2)
            }
            return length
        case .right:
            var length = frame.height
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
