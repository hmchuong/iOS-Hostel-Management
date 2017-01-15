//
//  UIBezierPath+Extension.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 11/17/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

public extension UIBezierPath {
    /// Draw entire bound of text field (for fill the background)
    ///
    /// - Parameters:
    ///   - topLeft: 'true' if top left corner is shown
    ///   - topRight: 'true' if top right corner is shown
    ///   - bottomLeft: 'true' if bottom left corner is shown
    ///   - bottomRight: 'true' if bottom right corner is shown
    ///   - y_start: the minimum of y-axis value
    ///   - y_end: the maximum of y-axis value
    ///   - width: the width of of background
    ///   - cornerRadius: the corner radius
    ///   - lineWidth: the width of border
    /// - Returns: UIBezierPath for the whole text field
    public static func getBackgroundPath(topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool, y_start: CGFloat, y_end: CGFloat, width: CGFloat, cornerRadius: CGFloat, lineWidth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        //Store the starting point of path
        var startPoint = CGPoint.zero
        
        //If top left corner is shown
        if topLeft {
            //Draw top left corner
            path.addArc(withCenter: CGPoint(x:cornerRadius + lineWidth ,
                                            y: cornerRadius + y_start),
                        radius: cornerRadius, startAngle: CGFloat(M_PI),
                        endAngle: CGFloat(M_PI*3/2),
                        clockwise: true)
            
            //startPoint = starting point of top left corner
            startPoint = CGPoint(x: lineWidth, y: y_start + cornerRadius)
            
        } else{
            //startPoint = starting point of text field
            path.move(to: CGPoint(x: lineWidth, y: y_start))
            startPoint = CGPoint(x: lineWidth, y: y_start)
        }
        
        
        
        //If top right corner is shown
        if topRight {
            //Draw line to the starting point of the top left corner
            path.addLine(to: CGPoint(x:width - cornerRadius - lineWidth, y: y_start))
            
            //Draw top right corner
            path.addArc(withCenter: CGPoint(x: width - cornerRadius - lineWidth,
                                            y:cornerRadius + y_start),
                        radius: cornerRadius,
                        startAngle: CGFloat(-M_PI/2),
                        endAngle: CGFloat(0),
                        clockwise: true)
        } else {
            //Draw line to the end of text field
            path.addLine(to: CGPoint(x:width - lineWidth, y: y_start))
        }
        
        
        
        //If bottom right corner is shown
        if bottomRight {
            //Draw line to the starting point of bottom right corner
            path.addLine(to: CGPoint(x:width - lineWidth, y: y_end - cornerRadius))
            
            //Draw bottom right corner
            path.addArc(withCenter: CGPoint(x:width - cornerRadius - lineWidth,
                                            y:y_end - cornerRadius),
                        radius: cornerRadius, startAngle: CGFloat(0),
                        endAngle: CGFloat(M_PI/2),
                        clockwise: true)
        } else {
            //Draw line to the end of text field
            path.addLine(to: CGPoint(x:width - lineWidth, y: y_end))
        }
        
        
        
        //If bottom left corner is shown
        if bottomLeft {
            //Draw line to the starting point of bottom left corner
            path.addLine(to: CGPoint(x: cornerRadius + lineWidth, y: y_end))
            
            //Draw bottom left corner
            path.addArc(withCenter: CGPoint(x:cornerRadius + lineWidth,
                                            y: y_end - cornerRadius),
                        radius: cornerRadius, startAngle: CGFloat(M_PI/2),
                        endAngle: CGFloat(M_PI),
                        clockwise: true)
        } else {
            //Draw line to minimum x-value of text field
            path.addLine(to: CGPoint(x: lineWidth, y: y_end))
        }
        
        //Draw line to the startPoint
        path.addLine(to: startPoint)
        
        return path 
    }
}
