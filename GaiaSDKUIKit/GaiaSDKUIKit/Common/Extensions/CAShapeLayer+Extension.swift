//
//  CAShapeLayer+Extension.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/17/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

public extension CAShapeLayer {
    //MARK: - Methods
    
    /// Draw corner in CAShapeLayer
    ///
    /// - Parameters:
    ///   - center: center point of corner
    ///   - startAngle: The starting angle of the corner
    ///   - radius: The radius of the corner ~ corner radius
    ///   - color: the color of line
    ///   - lineWidth: the width of line
    public func makeCorner(center: CGPoint, startAngle: CGFloat, radius: CGFloat, color: UIColor, lineWidth: CGFloat){
        // endAngle = startAngle + 90 degree
        let endAngle = startAngle + CGFloat(M_PI/2)
        //draw corner
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        //change the fill color
        self.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        self.strokeColor = color.cgColor
        //you can change the line width
        self.lineWidth = lineWidth
    }
    
    /// Draw background in CAShapeLayer
    ///
    /// - Parameters:
    ///   - topLeft: 'true' if top left corner is shown
    ///   - topRight: 'true' if top right corner is shown
    ///   - bottomLeft: 'true' if bottom left corner is shown
    ///   - bottomRight: 'true' if bottom right corner is shown
    ///   - y_start: the minimum of y-axis value
    ///   - y_end: the maximum of y-axis value
    ///   - width: the width of the text field
    ///   - cornerRadius: the corner radius
    ///   - borderWidth: the width of border
    ///   - fillColor: the color of background
    ///   - transparent: the transparent of background color
    public func makeBackground(topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool, y_start: CGFloat, y_end: CGFloat, width: CGFloat, cornerRadius: CGFloat, borderWidth: CGFloat, fillColor: String, transparent: CGFloat){
        self.path = UIBezierPath.getBackgroundPath(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight, y_start: y_start, y_end: y_end, width: width, cornerRadius: cornerRadius, lineWidth: borderWidth).cgPath
        
        self.fillColor = UIColor(hexString: fillColor, alpha: Float(transparent))?.cgColor
        self.strokeColor = UIColor.clear.cgColor
        self.lineWidth = 0        
    }
}
