//
//  GaiaDesignableLUIRainbow.swift
//  Holler
//
//  Created by Phong Le on 8/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
public class GaiaDesignableUIRainbow: UIView {
    @IBInspectable var firstColor: UIColor = UIColor(red: (37.0/255.0), green: (252.0/255), blue: (244.0/255.0), alpha: 1.0)
    @IBInspectable var secondColor: UIColor = UIColor(red: (171.0/255.0), green: (250.0/255), blue: (81.0/255.0), alpha: 1.0)
    @IBInspectable var thirdColor: UIColor = UIColor(red: (238.0/255.0), green: (32.0/255), blue: (53.0/255.0), alpha: 1.0)
    
    @IBInspectable public var innerCircleRadius:CGFloat = 80
    @IBInspectable public var middleCircleRadius:CGFloat = 150
    @IBInspectable public var outerCircleRadius:CGFloat = 215
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func draw(_ rect: CGRect) {
        // Add ARCs
        self.layer.sublayers = nil
        self.addCirle(innerCircleRadius, capRadius: 20, color: self.firstColor)
        self.addCirle(middleCircleRadius, capRadius: 20, color: self.secondColor)
        self.addCirle(outerCircleRadius, capRadius: 20, color: self.thirdColor)
    }
    
    func addCirle(_ arcRadius: CGFloat, capRadius: CGFloat, color: UIColor) {
        let X = self.bounds.midX
        let Y = self.bounds.midY
        
        // Bottom Oval
        let pathBottom = UIBezierPath(ovalIn: CGRect(x: (X - (arcRadius/2)), y: (Y - (arcRadius/2)), width: arcRadius, height: arcRadius)).cgPath
        self.addOval(20.0, path: pathBottom, strokeStart: 0, strokeEnd: 0.5, strokeColor: color, fillColor: UIColor.clear, shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSize.zero)
        
        // Middle Cap
        let pathMiddle = UIBezierPath(ovalIn: CGRect(x: (X - (capRadius/2)) - (arcRadius/2), y: (Y - (capRadius/2)), width: capRadius, height: capRadius)).cgPath
        self.addOval(0.0, path: pathMiddle, strokeStart: 0, strokeEnd: 1.0, strokeColor: color, fillColor: color, shadowRadius: 5.0, shadowOpacity: 0.5, shadowOffsset: CGSize.zero)
        
        // Top Oval
        let pathTop = UIBezierPath(ovalIn: CGRect(x: (X - (arcRadius/2)), y: (Y - (arcRadius/2)), width: arcRadius, height: arcRadius)).cgPath
        self.addOval(20.0, path: pathTop, strokeStart: 0.5, strokeEnd: 1.0, strokeColor: color, fillColor: UIColor.clear, shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSize.zero)
        
    }
    
    func addOval(_ lineWidth: CGFloat, path: CGPath, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {
        
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.cgColor
        arc.fillColor = fillColor.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        layer.addSublayer(arc)
    }
}
