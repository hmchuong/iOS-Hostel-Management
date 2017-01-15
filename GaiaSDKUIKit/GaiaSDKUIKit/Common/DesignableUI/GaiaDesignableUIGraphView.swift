//
//  GaiaDesignableUIGraphView.swift
//  Holler
//
//  Created by Phong Le on 25/3/16.
//  Copyright © 2016 Rainmaker-labs. All rights reserved.

import Foundation
import UIKit

@IBDesignable
public class  GaiaDesignableUIGraphView: UIView {
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clearsContextBeforeDrawing = true
    }


	// 1 - the properties for the gradient
	@IBInspectable public var startColor: UIColor = UIColor.red
	@IBInspectable public var endColor: UIColor = UIColor.green

	override public func draw(_ rect: CGRect) {
//        let width = rect.width
//        let height = rect.height
        layer.sublayers = nil
        //set up background clipping area
        let path = UIBezierPath(roundedRect: rect,
            byRoundingCorners: UIRectCorner.allCorners,
            cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
		// 2 - get the current context
		let context = UIGraphicsGetCurrentContext()
		let colors = [startColor.cgColor, endColor.cgColor]

		// 3 - set up the color space
		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// 4 - set up the color stops
		let colorLocations: [CGFloat] = [0.0, 1.0]

		// 5 - create the gradient
		let gradient = CGGradient(colorsSpace: colorSpace,
			colors: colors as CFArray,
			locations: colorLocations)

		// 6 - draw the gradient
		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: self.bounds.height)
		context?.drawLinearGradient(gradient!,
			start: startPoint,
			end: endPoint,
			options: CGGradientDrawingOptions.drawsAfterEndLocation)
        self.setNeedsDisplay()
	}
}
